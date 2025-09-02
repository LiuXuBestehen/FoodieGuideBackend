import logging

from fastapi import HTTPException

from crud.food.food_crud import food_crud,ingredient_crud
from crud.user.user_crud import user_crud,user_collect_food_crud

logger=logging.getLogger(__name__)

class OtherService:
    async def index_stats(self)->dict:
        logger.info("===开始查询网站的统计数据===")
        try:
            food_count = await food_crud.foods_total()
            ingredient_count = await ingredient_crud.ingredient_total()
            collect_count = await user_collect_food_crud.collect_total()
            user_count = await user_crud.user_total()

            logger.info(f"===获取到的统计数据分别为 美食：{food_count} 食材:{ingredient_count} 收藏:{collect_count} 用户:{user_count}")

            return {
                "food": food_count,
                "ingredient": ingredient_count,
                "collect": collect_count,
                "user": user_count
            }
        except Exception as e:
            logger.error(f"===获取网站统计数据时出错,信息：{e}===")
            raise HTTPException(detail="服务端计算统计数据出错",status_code=500)




other_service = OtherService()