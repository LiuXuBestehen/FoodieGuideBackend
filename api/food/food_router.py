from fastapi import APIRouter, Depends

from core.security.user.user_utils import get_current_user
from schemas.food.food_schemas import FoodCreate,FoodUpdate,IngredientsUpdate,IngredientsCreate,QuestionnaireCreate,QuestionnaireUpdate
from services.food.food_service import food_service
from schemas.base.base_response_model import BaseResponseModel
import logging

logger=logging.getLogger(__name__)

router = APIRouter()

# 分页查询美食信息
@router.post("/getFoodByPage",response_model=BaseResponseModel)
async def get_foods(page:int,page_size:int,filters:dict | None=None):
    foods=await food_service.get_foods_by_page(page=page,page_size=page_size,filters=filters)
    return BaseResponseModel.success_request(data=foods)

# 创建美食信息
@router.post("/createFood",response_model=BaseResponseModel)
async def create_food(new_food:FoodCreate,user=Depends(get_current_user)):
    food=await food_service.create_food_service(food_create=new_food)
    return BaseResponseModel.success_request(data=food)

# 更新美食信息
@router.post("/updateFood",response_model=BaseResponseModel)
async def update_food(request_food:FoodUpdate,user=Depends(get_current_user)):
    food=await food_service.update_food_service(food_update=request_food)
    return BaseResponseModel.success_request(data=food)

#删除美食信息
@router.delete("/deleteFood",response_model=BaseResponseModel)
async def delete_food(food_id:int,user=Depends(get_current_user)):
    result = await food_service.delete_food_by_id(food_id=food_id)
    return BaseResponseModel.success_request(data=result)
"""
获取全部美食去重分类接口
"""
@router.get("/getFoodCategories",response_model=BaseResponseModel)
async def get_food_categories():
    categories = await food_service.get_food_category_duplicate_removal()
    return BaseResponseModel.success_request(data=categories)

"""
获取前num个排行榜美食信息
"""
@router.get("/getFoodTheChartsInNum",response_model=BaseResponseModel)
async def get_food_by_the_charts_in_num(num:int):
    result = await food_service.get_the_charts_foods_in_num(num=num)
    return BaseResponseModel.success_request(data=result)

# 分页查询食材信息
@router.post("/getIngredientByPage",response_model=BaseResponseModel)
async def get_ingredient(page:int,page_size:int,filters:dict | None=None):
    ingredients=await food_service.get_ingredient_by_page(page=page,page_size=page_size,filters=filters)
    return BaseResponseModel.success_request(data=ingredients)

# 创建食材信息
@router.post("/createIngredient",response_model=BaseResponseModel)
async def create_ingredient(new_ingredient:IngredientsCreate,user=Depends(get_current_user)):
    ingredient=await food_service.create_ingredient_service(ingredient_create=new_ingredient)
    return BaseResponseModel.success_request(data=ingredient)

# 更新美食信息
@router.post("/updateIngredient",response_model=BaseResponseModel)
async def update_ingredient(request_ingredient:IngredientsUpdate,user=Depends(get_current_user)):
    ingredient=await food_service.update_ingredient_service(ingredient_update=request_ingredient)
    return BaseResponseModel.success_request(data=ingredient)

#删除美食信息
@router.delete("/deleteIngredient",response_model=BaseResponseModel)
async def delete_ingredient(ingredient_id:int,user=Depends(get_current_user)):
    result = await food_service.delete_ingredient_by_id(ingredient_id=ingredient_id)
    return BaseResponseModel.success_request(data=result)

# 分页查询问卷信息
@router.post("/getQuestionnaireByPage",response_model=BaseResponseModel)
async def get_questionnaire(page:int,page_size:int,filters:dict | None=None):
    questionnaire=await food_service.get_questionnaire_by_page(page=page,page_size=page_size,filters=filters)
    return BaseResponseModel.success_request(data=questionnaire)

# 创建问卷信息
@router.post("/createQuestionnaire",response_model=BaseResponseModel)
async def create_questionnaire(new_questionnaire:QuestionnaireCreate,user=Depends(get_current_user)):
    questionnaire=await food_service.create_questionnaire_service(questionnaire_create=new_questionnaire)
    return BaseResponseModel.success_request(data=questionnaire)

# 更新问卷信息
@router.post("/updateQuestionnaire",response_model=BaseResponseModel)
async def update_questionnaire(request_questionnaire:QuestionnaireUpdate,user=Depends(get_current_user)):
    questionnaire=await food_service.update_questionnaire_service(questionnaire_update=request_questionnaire)
    return BaseResponseModel.success_request(data=questionnaire)

#删除问卷信息
@router.delete("/deleteQuestionnaire",response_model=BaseResponseModel)
async def delete_questionnaire(questionnaire_id:int,user=Depends(get_current_user)):
    result = await food_service.delete_questionnaire_by_id(questionnaire_id=questionnaire_id)
    return BaseResponseModel.success_request(data=result)