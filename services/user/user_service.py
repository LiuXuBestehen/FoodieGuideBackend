from datetime import timedelta
from typing import List

from starlette import status
from config import Config
from crud.user.user_crud import user_crud,user_collect_food_crud
from crud.food.food_crud import the_charts_crud, food_crud
from schemas.user.user_schemas import UserCreate, User, UserLogin, Token, UserUpdate,UserCollectFoodCreateOrUpdate
from schemas.food.food_schemas import Food
from fastapi import HTTPException
from core.security.user.user_utils import get_password_hash,verify_password,create_access_token
import logging

logger = logging.getLogger(__name__)


class UserService:
    """
    注册用户
    """
    async def register_user(self, user_data: UserCreate) -> User:
        logger.info("===register_user 开始注册用户===")
        # 业务逻辑验证
        if await user_crud.get_by_email(user_data.email):
            logger.error(f"===register_user 查询到注册邮箱已经存在===")
            raise HTTPException(status_code=200, detail="邮箱已存在")

        if await user_crud.get_by_username(user_data.username):
            logger.error(f"===register_user 查询到注册用户名已经存在===")
            raise HTTPException(status_code=200, detail="用户名已存在")

        #将密码转换成hashPassword,同时补充数据
        user_data.password = get_password_hash(user_data.password)

        logger.info(f"===register_user 创建的用户实际信息：{user_data}===")
        # 创建用户
        user_model = await user_crud.create(user_data)

        #将用户转换成pydanticSchemas
        return User.model_validate(user_model)

    """
    用户登录
    """
    async def login_user(self, user_data: UserLogin) -> Token:
        logger.info("===login_user 开始进行登录===")

        user = await user_crud.get_by_email(user_data.email)
        # 校验用户是否注册
        if not user:
            logger.error(f"===login_user 用户名未注册===")
            raise HTTPException(
                status_code=200,
                detail="用户未注册",
                headers={"WWW-Authenticate": "Bearer"},
            )
        # 校验密码是否正确
        if  not verify_password(user_data.password, user.password):
            logger.error(f"===login_user 用户名或密码错误===")
            raise HTTPException(
                status_code=200,
                detail="用户名或密码错误",
                headers={"WWW-Authenticate": "Bearer"},
            )

        access_token_expires = timedelta(minutes=Config.ACCESS_TOKEN_EXPIRE_MINUTES)
        access_token = create_access_token(
            data={"user_id": user.id,"role":user.role,"email":user.email,"username":user.username,"constitution":user.constitution}, expires_delta=access_token_expires
        )
        return Token(access_token=access_token, token_type="bearer")

    """
    通过ID获取用户
    """
    async def get_user_by_id(self,user_id:int)->User:
        user=await user_crud.get(id=user_id)
        if user is None:
            raise HTTPException(status_code=404,detail=f"未找到id为{user_id}的用户")
        return User.model_validate(user)

    """
    通过id更新用户
    """
    async def update_user_by_id(self,user_id:int,user_data:UserUpdate)->User:
        user=await user_crud.update(id=user_id,obj_in=user_data)
        if user is None:
            raise HTTPException(status_code=404,detail=f"更新ID={user_id}的用户失败,用户不存在")
        return User.model_validate(user)

    """
    获取用户的收藏列表美食id
    """
    async def get_liked_foods_ids(self,user_id:int)->List[int]:
        logger.info(f"===get_liked_foods 开始获取{user_id}用户喜欢的美食列表")
        liked_foods= await user_collect_food_crud.get_liked_foods_ids_by_id(user_id=user_id)
        return liked_foods

    """
    获取用户的收藏列表美食
    """
    async def get_liked_foods_by_user_id(self, user_id: int) -> List[Food]:
        logger.info(f"===get_liked_foods_by_user_id 开始获取{user_id}用户喜欢的美食列表===")
        try:
            # 先找到用户收藏的美食id
            liked_foods= await user_collect_food_crud.get_liked_foods_ids_by_id(user_id=user_id)
            # 再批量获取到Food,同时转换成schema的Food
            if len(liked_foods) == 0:
                return []
            return [Food.model_validate(await food_crud.get(id=food_id)) for food_id in liked_foods]
        except Exception as e:
            logger.error(f"===get_liked_foods_by_user_id 获取{user_id}用户喜欢的美食列表出现错误{e}===")
            raise HTTPException(status_code=500, detail="获取用户收藏错误")

    """
    收藏美食
    """
    async def create_liked_food(self,user_liked_food:UserCollectFoodCreateOrUpdate)->bool:
        logger.info(f"===create_liked_food 开始创建用户喜欢的美食")
        # 将用户喜欢的数据增加到收藏表
        result=await user_collect_food_crud.create(obj_in=user_liked_food)
        # 使用food_id,将食物添加到排行表
        the_charts_result=await the_charts_crud.add_the_charts(food_id=user_liked_food.food_id)
        if (result is None) | (the_charts_result is False):
            raise HTTPException(status_code=404, detail="创建用户喜欢美食记录失败")
        else:
            return True

    """
    删除收藏的美食
    """
    async def delete_liked_food(self,user_id:int,food_id)->bool:
        logger.info(f"===delete_liked_food 开始删除用户喜欢的美食")
        # 从收藏表移除用户和美食关联
        result=await user_collect_food_crud.delete_liked_food(user_id=user_id, food_id=food_id)
        # 同时排查排行表
        the_charts_resul=await the_charts_crud.delete_the_charts(food_id=food_id)
        if (not result) | (the_charts_resul is False):
            raise HTTPException(status_code=404, detail="删除用户喜欢美食记录失败")
        else:
            return result

user_service = UserService()

