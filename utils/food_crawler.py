import asyncio
import json
import csv
import time
from datetime import datetime
from playwright.async_api import async_playwright
from typing import List, Dict, Optional


class FoodCrawler:
    def __init__(self):
        self.browser = None
        self.page = None
        self.results = []

    async def init(self, headless: bool = False, user_agent: str = None, user_data_dir: str = None):
        """初始化浏览器"""
        self.playwright = await async_playwright().start()

        # 浏览器启动配置
        launch_options = {
            'headless': headless,
            'slow_mo': 100,  # 减慢操作速度，避免被反爬
            'args': [
                '--no-sandbox',
                '--disable-blink-features=AutomationControlled',
                '--disable-web-security',
                '--disable-features=VizDisplayCompositor'
            ]
        }

        # 如果指定了用户数据目录，使用持久化上下文
        if user_data_dir:
            launch_options['user_data_dir'] = user_data_dir

        self.browser = await self.playwright.chromium.launch(**launch_options)

        # 默认user_agent
        default_user_agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'

        # 创建浏览器上下文
        context_options = {
            'user_agent': user_agent or default_user_agent,
            'viewport': {"width": 1920, "height": 1080},
            'extra_http_headers': {
                'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8',
                'Accept-Encoding': 'gzip, deflate, br',
                'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
                'Sec-Ch-Ua': '"Not_A Brand";v="8", "Chromium";v="120", "Google Chrome";v="120"',
                'Sec-Ch-Ua-Mobile': '?0',
                'Sec-Ch-Ua-Platform': '"Windows"',
                'Sec-Fetch-Dest': 'document',
                'Sec-Fetch-Mode': 'navigate',
                'Sec-Fetch-Site': 'none',
                'Sec-Fetch-User': '?1',
                'Upgrade-Insecure-Requests': '1'
            }
        }

        self.context = await self.browser.new_context(**context_options)

        # 创建新页面
        self.page = await self.context.new_page()

        # 注入脚本以隐藏自动化特征
        await self.page.add_init_script("""
            Object.defineProperty(navigator, 'webdriver', {
                get: () => undefined,
            });

            window.chrome = {
                runtime: {},
            };

            Object.defineProperty(navigator, 'plugins', {
                get: () => [1, 2, 3, 4, 5],
            });

            Object.defineProperty(navigator, 'languages', {
                get: () => ['zh-CN', 'zh', 'en'],
            });
        """)

        print(f'浏览器初始化完成，User-Agent: {user_agent or default_user_agent}')

    async def crawl_food(self, url: str, selectors: Dict[str, str]) -> List[Dict[str, str]]:
        """爬取指定网址的美食信息"""
        try:
            print(f'开始爬取: {url}')

            # 访问目标网址
            await self.page.goto(url, wait_until='networkidle', timeout=30000)

            # 等待页面加载完成
            await self.page.wait_for_timeout(2000)

            # 滚动页面确保内容完全加载
            await self.scroll_to_bottom()

            # 提取美食信息
            food_items = await self.page.evaluate("""
                (selectors) => {
                    const items = [];

                    // 根据选择器提取数据
                    const foodElements = document.querySelectorAll(selectors.containerSelector);

                    foodElements.forEach((element) => {
                        try {
                            // 提取美食名称
                            const nameElement = element.querySelector(selectors.nameSelector);
                            const name = nameElement ? nameElement.textContent.trim() : '';

                            // 提取所属地区
                            const regionElement = element.querySelector(selectors.regionSelector);
                            const region = regionElement ? regionElement.textContent.trim() : '';

                            // 提取其他可能的信息
                            const descElement = element.querySelector(selectors.descSelector || '');
                            const desc = descElement ? descElement.textContent.trim() : '';

                            // 获取链接
                            const linkElement = element.querySelector('a');
                            const link = linkElement ? linkElement.href : '';

                            // 只有当名称和地区都不为空时才添加
                            if (name && region) {
                                items.push({
                                    name: name,
                                    region: region,
                                    description: desc,
                                    link: link,
                                    source_url: window.location.href,
                                    crawl_time: new Date().toISOString()
                                });
                            }
                        } catch (error) {
                            console.error('提取单个项目时出错:', error);
                        }
                    });

                    return items;
                }
            """, selectors)

            print(f'从当前页面提取到 {len(food_items)} 条美食信息')
            self.results.extend(food_items)

            return food_items

        except Exception as error:
            print(f'爬取 {url} 时出错: {error}')
            return []

    async def scroll_to_bottom(self):
        """滚动到页面底部，确保动态内容加载"""
        await self.page.evaluate("""
            async () => {
                await new Promise((resolve) => {
                    let totalHeight = 0;
                    const distance = 100;
                    const timer = setInterval(() => {
                        const scrollHeight = document.body.scrollHeight;
                        window.scrollBy(0, distance);
                        totalHeight += distance;

                        if (totalHeight >= scrollHeight) {
                            clearInterval(timer);
                            resolve();
                        }
                    }, 100);
                });
            }
        """)

    async def handle_pagination(self, next_page_selector: str, max_pages: int = 10) -> None:
        """处理分页（如果有的话）"""
        current_page = 1

        while current_page < max_pages:
            try:
                # 检查是否有下一页按钮
                next_button = await self.page.query_selector(next_page_selector)
                if not next_button:
                    print('没有找到下一页按钮，爬取完成')
                    break

                # 检查按钮是否可点击
                is_disabled = await next_button.evaluate(
                    "el => el.disabled || el.classList.contains('disabled')"
                )

                if is_disabled:
                    print('已到达最后一页')
                    break

                # 点击下一页
                await next_button.click()
                await self.page.wait_for_timeout(3000)

                current_page += 1
                print(f'正在爬取第 {current_page} 页')

                # 重新提取当前页面的数据
                # 这里需要根据具体网站调整

            except Exception as error:
                print(f'处理分页时出错: {error}')
                break

    async def crawl_with_pagination(self, url: str, selectors: Dict[str, str],
                                    next_page_selector: str = None, max_pages: int = 10) -> List[Dict[str, str]]:
        """带分页的爬取功能"""
        # 先爬取第一页
        await self.crawl_food(url, selectors)

        # 如果有分页选择器，继续爬取其他页面
        if next_page_selector:
            await self.handle_pagination(next_page_selector, max_pages)

        return self.results

    def remove_duplicates(self) -> List[Dict[str, str]]:
        """去除重复数据"""
        seen = set()
        unique_results = []

        for item in self.results:
            # 使用名称和地区作为唯一标识
            key = (item['name'], item['region'])
            if key not in seen:
                seen.add(key)
                unique_results.append(item)

        return unique_results

    def save_results(self, filename: str = 'food_data') -> Dict[str, int]:
        """保存结果到文件"""
        try:
            # 去重
            unique_results = self.remove_duplicates()

            # 添加时间戳到文件名
            timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')

            # 保存为JSON格式
            json_filename = f'{filename}_{timestamp}.json'
            with open(json_filename, 'w', encoding='utf-8') as f:
                json.dump(unique_results, f, ensure_ascii=False, indent=2)

            # 保存为CSV格式
            csv_filename = f'{filename}_{timestamp}.csv'
            if unique_results:
                with open(csv_filename, 'w', newline='', encoding='utf-8') as f:
                    writer = csv.DictWriter(f, fieldnames=unique_results[0].keys())
                    writer.writeheader()
                    writer.writerows(unique_results)

            print(f'结果已保存到 {json_filename} 和 {csv_filename}')
            print(f'共爬取到 {len(unique_results)} 条唯一的美食信息')

            return {
                'total': len(self.results),
                'unique': len(unique_results),
                'json_file': json_filename,
                'csv_file': csv_filename
            }

        except Exception as error:
            print(f'保存结果时出错: {error}')
            return {}

    async def close(self):
        """关闭浏览器"""
        if self.context:
            await self.context.close()
        if self.browser:
            await self.browser.close()
            await self.playwright.stop()
            print('浏览器已关闭')

    async def wait_for_manual_login(self, login_page_url: str, success_check_selector: str = None,
                                    timeout: int = 300) -> bool:
        """等待用户手动登录"""
        try:
            print(f'打开登录页面: {login_page_url}')
            await self.page.goto(login_page_url, wait_until='networkidle')

            print('请在浏览器中手动完成登录...')
            print('登录完成后，脚本将自动继续执行')

            # 等待登录成功的标识
            if success_check_selector:
                try:
                    await self.page.wait_for_selector(success_check_selector, timeout=timeout * 1000)
                    print('检测到登录成功')
                except:
                    print('未检测到登录成功标识，但继续执行')
            else:
                # 简单等待URL变化或用户确认
                print(f'等待 {timeout} 秒或按 Ctrl+C 继续...')
                try:
                    await asyncio.sleep(timeout)
                except KeyboardInterrupt:
                    print('用户确认继续执行')

            # 保存登录状态
            await self.save_login_state('manual_login_cookies.json')
            return True

        except Exception as error:
            print(f'等待手动登录时出错: {error}')
            return False

    async def open_page_and_wait(self, url: str, wait_message: str = "请在浏览器中完成操作",
                                 wait_time: int = 60) -> bool:
        """打开页面并等待用户操作"""
        try:
            print(f'打开页面: {url}')
            await self.page.goto(url, wait_until='networkidle')

            print(f'{wait_message}')
            print(f'等待 {wait_time} 秒或按 Ctrl+C 继续...')

            try:
                await asyncio.sleep(wait_time)
            except KeyboardInterrupt:
                print('用户确认继续执行')

            return True

        except Exception as error:
            print(f'打开页面等待时出错: {error}')
            return False

    async def save_login_state(self, cookies_file: str = 'cookies.json'):
        """保存登录状态"""
        try:
            # 获取cookies
            cookies = await self.context.cookies()

            # 获取localStorage
            local_storage = await self.page.evaluate('() => JSON.stringify(localStorage)')

            # 保存到文件
            login_state = {
                'cookies': cookies,
                'localStorage': json.loads(local_storage),
                'timestamp': datetime.now().isoformat()
            }

            with open(cookies_file, 'w', encoding='utf-8') as f:
                json.dump(login_state, f, ensure_ascii=False, indent=2)

            print(f'登录状态已保存到 {cookies_file}')

        except Exception as e:
            print(f'保存登录状态时出错: {e}')

    async def load_login_state(self, cookies_file: str = 'cookies.json') -> bool:
        """加载已保存的登录状态"""
        try:
            with open(cookies_file, 'r', encoding='utf-8') as f:
                login_state = json.load(f)

            # 恢复cookies
            if 'cookies' in login_state:
                await self.context.add_cookies(login_state['cookies'])

            # 恢复localStorage（需要在页面加载后设置）
            if 'localStorage' in login_state:
                for key, value in login_state['localStorage'].items():
                    await self.page.evaluate(f'localStorage.setItem("{key}", "{value}")')

            print('登录状态已恢复')
            return True

        except FileNotFoundError:
            print('未找到保存的登录状态文件')
            return False
        except Exception as e:
            print(f'加载登录状态时出错: {e}')
            return False

    async def check_login_status(self, check_selector: str = None, check_url: str = None) -> bool:
        """检查登录状态"""
        try:
            if check_url:
                await self.page.goto(check_url, wait_until='networkidle')

            if check_selector:
                # 检查特定元素是否存在（如用户名、退出按钮等）
                try:
                    await self.page.wait_for_selector(check_selector, timeout=5000)
                    print('已检测到登录状态')
                    return True
                except:
                    print('未检测到登录状态')
                    return False

            # 简单检查：看是否被重定向到登录页面
            current_url = self.page.url
            if 'login' in current_url.lower() or 'signin' in current_url.lower():
                print('当前在登录页面，需要登录')
                return False

            return True

        except Exception as e:
            print(f'检查登录状态时出错: {e}')
            return False


    async def delay(self, seconds: float):
        """添加延时"""
        await asyncio.sleep(seconds)


# 使用示例
async def main():
    # 自定义User-Agent列表（可以随机选择或指定使用）
    user_agents = [
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36',
        'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/121.0',
        'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.2 Safari/605.1.15'
    ]

    # 选择要使用的User-Agent
    selected_user_agent = user_agents[0]  # 或者随机选择: random.choice(user_agents)

    crawler = FoodCrawler()

    try:
        # 初始化浏览器，手动指定User-Agent
        await crawler.init(headless=False, user_agent=selected_user_agent)

        # 配置要爬取的网址和选择器
        crawl_configs = [
            # {
            #     'url': 'https://example.com/protected-food-list',  # 需要登录的页面
            #     'selectors': {
            #         'containerSelector': '.food-item',
            #         'nameSelector': '.food-name',
            #         'regionSelector': '.food-region',
            #         'descSelector': '.food-desc'
            #     },
            #     'requires_manual_setup': True,
            #     'login_url': 'https://example.com/login',  # 登录页面
            #     'setup_instructions': '请手动登录后继续'
            # },
            {
                'url': 'https://www.ihchina.cn/project.html',  # 不需要登录的页面
                'selectors': {
                    'containerSelector': '.food-item',
                    'nameSelector': '.food-name',
                    'regionSelector': '.food-region'
                },
                'requires_manual_setup': False
            }
        ]

        # 爬取所有配置的网站
        for config in crawl_configs:
            print(f"\n开始处理网站: {config['url']}")

            if config.get('requires_manual_setup', False):
                # 需要手动设置的页面
                await crawler.crawl_with_manual_setup(
                    config['url'],
                    config['selectors'],
                    config.get('login_url'),
                    config.get('setup_instructions')
                )
            else:
                # 直接爬取的页面
                await crawler.crawl_food(config['url'], config['selectors'])

            # 延时避免请求过快
            await crawler.delay(2)

        # 保存结果
        result_info = crawler.save_results('chinese_food_heritage')
        print(f"\n爬取完成！共获取 {result_info.get('unique', 0)} 条唯一美食信息")

    except Exception as error:
        print(f'爬虫执行出错: {error}')
    finally:
        await crawler.close()


# 简单的手动登录爬取函数
async def simple_manual_crawl(url: str, selectors: Dict[str, str],
                              user_agent: str = None, login_url: str = None,
                              headless: bool = False):
    """简单的手动设置爬取函数"""
    crawler = FoodCrawler()
    try:
        await crawler.init(headless=headless, user_agent=user_agent)

        if login_url:
            # 需要手动登录
            result = await crawler.crawl_with_manual_setup(url, selectors, login_url)
        else:
            # 直接爬取
            result = await crawler.crawl_food(url, selectors)

        result_info = crawler.save_results('food_manual')
        return result_info
    finally:
        await crawler.close()


# 运行爬虫
if __name__ == "__main__":
    # 运行主爬虫
    asyncio.run(main())

    # 或者使用简单手动版本
    # custom_user_agent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
    #
    # result = asyncio.run(simple_manual_crawl(
    #     url='https://example.com/food-page',
    #     selectors={
    #         'containerSelector': '.food-item',
    #         'nameSelector': '.name',
    #         'regionSelector': '.region'
    #     },
    #     user_agent=custom_user_agent,
    #     login_url='https://example.com/login'  # 如果需要登录
    # ))
