from crud.base import CRUDBase
from crud.food.food_crud import food_crud
from models.food import Foods
from models.user import User,UserCollectFood
from schemas.user.user_schemas import UserCreate, UserUpdate,UserCollectFoodCreateOrUpdate
from typing import Optional, List


class CRUDUser(CRUDBase[User, UserCreate, UserUpdate]):
    """
    通过email获取用户信息
    """
    async def get_by_email(self, email: str) -> Optional[User]:
        return await self.model.get_or_none(email=email)
    """
    通过username获取用户信息
    """
    async def get_by_username(self, username: str) -> Optional[User]:
        return await self.model.get_or_none(username=username)

    # is_active=True条件可以换成constitution="xxx",用于筛选体质信息
    async def get_active_users(self, skip: int = 0, limit: int = 100) -> List[User]:
        return await self.model.filter(is_active=True).offset(skip).limit(limit)

    """
    返回全部用户个数
    """
    async def user_total(self)->int:
        obj=await self.model.all().count()
        return obj

class CRUDUserCollectFood(CRUDBase[UserCollectFood, UserCollectFoodCreateOrUpdate, UserCollectFoodCreateOrUpdate]):
    """
    通过user_id获取用户收藏列表的美食id
    """
    async def get_liked_foods_ids_by_id(self, user_id: int) -> List[int]:
        filter_data=await self.model.filter(user_id=user_id)
        result=[f.food_id for f in filter_data]
        return result

    """
    使用user_id定位用户收藏列表,从列表移除food_id对应的数据
    """
    async def delete_liked_food(self,user_id:int,food_id:int)->bool:
        obj = await self.model.filter(user_id=user_id, food_id=food_id).first()
        if obj:
            await obj.delete()
            return True
        return False

    """
    通过food_id移除全部用户收藏
    """
    async def remove_from_food(self,food_id:int)->bool:
        obj = await self.model.filter(food_id=food_id)
        if obj:
            for f in obj:
                await f.delete()
            return True
        return False

    """
    返回全部收藏点赞个数
    """
    async def collect_total(self)->int:
        obj = await self.model.all().count()
        return obj

user_collect_food_crud=CRUDUserCollectFood(UserCollectFood)
user_crud = CRUDUser(User)