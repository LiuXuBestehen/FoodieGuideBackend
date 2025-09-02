from fastapi import APIRouter, Depends

from core.security.user.user_utils import get_current_user
from services.user.user_service import user_service
from schemas.user.user_schemas import UserCreate, UserLogin, UserUpdate,UserCollectFoodCreateOrUpdate
from schemas.base.base_response_model import BaseResponseModel
import logging

logger=logging.getLogger(__name__)
router = APIRouter()

#接口需要鉴权的，在定义方法的接受参数中加user=Depends(get_current_user)。FastAPI会自动进行鉴权

# 用户注册
@router.post("/register", response_model=BaseResponseModel)
async def register(user: UserCreate):
    user = await user_service.register_user(user_data=user)
    return BaseResponseModel.success_request(data=user)


# 用户登录
@router.post("/login", response_model=BaseResponseModel)
async def login(user_credentials: UserLogin):
    token = await user_service.login_user(user_data=user_credentials)
    return BaseResponseModel.success_request(data=token)

# ID查询用户信息
@router.get("/getUserById",response_model=BaseResponseModel)
async def get_user_by_id(user_id: int,user=Depends(get_current_user)):
    user= await user_service.get_user_by_id(user_id=user_id)
    return BaseResponseModel.success_request(data=user)

# ID更新用户信息
@router.post("/updateUserById",response_model=BaseResponseModel)
async def update_user_by_id(user_id:int,update_user: UserUpdate,user=Depends(get_current_user)):
    user = await user_service.update_user_by_id(user_id=user_id, user_data=update_user)
    return BaseResponseModel.success_request(data=user)

# 获取用户收藏列表ids
@router.get("/getUserLikedFoodsIds",response_model=BaseResponseModel)
async def get_user_liked_foods_ids(user_id: int,user=Depends(get_current_user)):
    result = await user_service.get_liked_foods_ids(user_id=user_id)
    return BaseResponseModel.success_request(data=result)

"""
获取用户收藏美食信息
"""
@router.get("/getUserLikedFoods",response_model=BaseResponseModel)
async def get_user_liked_foods(user_id: int,user=Depends(get_current_user)):
    result = await user_service.get_liked_foods_by_user_id(user_id=user_id)
    return BaseResponseModel.success_request(data=result)

# 更新用户收藏
@router.post("/createUserLikedFood",response_model=BaseResponseModel)
async def create_user_liked_food(liked_food:UserCollectFoodCreateOrUpdate,user=Depends(get_current_user)):
    result=await user_service.create_liked_food(user_liked_food=liked_food)
    return BaseResponseModel.success_request(data=result)

# 移除用户收藏
@router.post("/deleteUserLikedFood",response_model=BaseResponseModel)
async def delete_user_liked_food(delete_food:UserCollectFoodCreateOrUpdate,user=Depends(get_current_user)):
    result=await user_service.delete_liked_food(user_id=delete_food.user_id, food_id=delete_food.food_id)
    return BaseResponseModel.success_request(data=result)
