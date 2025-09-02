from typing import List, Set

from fastapi import HTTPException

from crud.user.user_crud import user_collect_food_crud
from schemas.food.food_schemas import (Food,
                                       FoodCreate,
                                       FoodUpdate,
                                       Ingredients,
                                       IngredientsCreate,
                                       IngredientsUpdate,
                                       Questionnaire,
                                       QuestionnaireCreate,
                                       QuestionnaireUpdate)
from crud.food.food_crud import food_crud,ingredient_crud,questionnaire_crud,the_charts_crud
from crud.region.region_crud import region_food_relation_crud
import logging

logger = logging.getLogger(__name__)


class FoodService:
    # 分页获取美食信息
    async def get_foods_by_page(self,page:int,page_size:int,filters:dict | None) -> dict:
        logger.info("===get_foods_by_page 开始分页查询食物信息===")
        try:
            foods_model=await food_crud.get_foods_by_page(page=page,page_size=page_size,filters=filters)
            foods_schema=[Food.model_validate(r) for r in foods_model]
            if filters:
                total = await food_crud.filter_food_total(filters=filters)
            else:
                total = await food_crud.foods_total()
            if total is None: total = 0
            logger.info(f"===get_foods_by_page 美食总数:{total}===")
            logger.info(f"===get_foods_by_page 查询美食数据: {foods_schema}===")
            return {"foods":foods_schema,"total":total}
        except Exception as e:
            logger.error(f"===get_foods_by_page 出现错误，内容：{e}===")
            raise
    #创建美食信息
    async def create_food_service(self,food_create:FoodCreate) -> Food:
        logger.info("===create_food_service 开始创建食物信息===")
        try:
            food_temp = await food_crud.create(food_create)
            # 增加维护region和food关系表的数据
            await region_food_relation_crud.set_or_add_region_food_relation(region_id=food_temp.region_id,food_id=food_temp.id,is_food=True)

            food_result=Food.model_validate(food_temp)
            logger.info(f"===create_food_service 创建的数据: {food_result}===")
            return food_result
        except Exception as e:
            logger.error(f"===create_food_service 出现错误，内容：{e}===")
            raise
    #更新美食信息
    async def update_food_service(self,food_update:FoodUpdate) -> Food:
        logger.info("===update_food_service 开始更新食物信息===")
        try:
            before_update_food=await food_crud.get(id=food_update.id)
            food_temp=await food_crud.update(id=food_update.id,obj_in=food_update)
            # 增加维护region和food关系表的数据,先删除老的在设置新的
            await region_food_relation_crud.delete_region_food_relation(region_id=before_update_food.region_id,food_id=food_temp.id,is_food=True)
            await region_food_relation_crud.set_or_add_region_food_relation(region_id=food_temp.region_id,food_id=food_temp.id,is_food=True)

            food_result=Food.model_validate(food_temp)
            logger.info(f"===update_food_service 更新的数据: {food_result}===")
            return food_result
        except Exception as e:
            logger.error(f"===update_food_service 出现错误，内容：{e}===")
            raise
    #删除美食信息
    async def delete_food_by_id(self,food_id:int) -> bool:
        logger.info("===delete_food 开始删除美食信息===")
        try:
            food_temp=await food_crud.get(id=food_id)
            # 增加维护region和food关系表的数据
            await region_food_relation_crud.delete_region_food_relation(region_id=food_temp.region_id,food_id=food_temp.id,is_food=True)
            # 增加the_charts和user_collect_food同步删除
            await the_charts_crud.remove_the_charts(food_id=food_id)
            await user_collect_food_crud.remove_from_food(food_id=food_id)
            delete_result=await food_crud.delete(food_id)
            if delete_result is True:
                logger.info(f"===delete_food 成功删除id为: {food_id}->的数据===")
            else:
                logger.info(f"===delete_food 失败删除id为: {food_id}->的数据===")
            return delete_result
        except Exception as e:
            logger.error(f"===delete_food 出现错误{e}===")
            raise
    #获取全部美食的去重分类
    async def get_food_category_duplicate_removal(self) -> Set[str]:
        logger.info("===get_food_category_duplicate_removal 开始获取全部美食去重分类数据===")
        try:
            category_result=await food_crud.get_food_categories()
            if len(category_result) == 0:
                logger.error("===get_food_category_duplicate_removal 统计美食去重分类数据为零，请查看数据是否正常===")
            return category_result
        except Exception as e:
            logger.error(f"===get_food_category_duplicate_removal 统计分类数据出现错误，信息为：{e}===")

    """
    获取排行榜美食列表
    """
    async def get_the_charts_foods_in_num(self,num:int)->List[Food]:
        logger.info(f"===get_the_charts_foods_in_num 开始获取排行榜前{num}个美食信息===")
        try:
         #先找到排行榜前num个的美食id
         the_charts_food_ids=await the_charts_crud.get_foods_ids_from_the_charts(num=num)
         #再批量获取到Food,同时转换成schema的Food
         if len(the_charts_food_ids) == 0:
            return []
         return [Food.model_validate(await food_crud.get(id=food_id)) for food_id in the_charts_food_ids]
        except Exception as e:
            logger.error(f"===get_the_charts_foods_in_num 获取排行榜美食信息出现错误{e}===")
            raise HTTPException(status_code=500,detail="获取排行榜信息错误")

    #分页查询食材信息
    async def get_ingredient_by_page(self,page:int,page_size:int,filters:dict | None) -> dict:
        logger.info("===get_ingredient_by_page 开始分页查询食物信息===")
        try:
            ingredient_model=await ingredient_crud.get_ingredient_by_page(page=page,page_size=page_size,filters=filters)
            ingredient_schema=[Ingredients.model_validate(r) for r in ingredient_model]
            if filters:
                total = await ingredient_crud.filter_ingredient_total(filters=filters)
            else:
                total = await ingredient_crud.ingredient_total()
            if total is None: total = 0
            logger.info(f"===get_ingredient_by_page 食材总数:{total}===")
            logger.info(f"===get_ingredient_by_page 查询食材数据: {ingredient_schema}===")
            return {"ingredient":ingredient_schema,"total":total}
        except Exception as e:
            logger.error(f"===get_ingredient_by_page 出现错误，内容：{e}===")
            raise
    #创建食材信息
    async def create_ingredient_service(self, ingredient_create: IngredientsCreate) -> Ingredients:
        logger.info("===create_ingredient_service 开始创建食材信息===")
        try:
            ingredient_temp = await ingredient_crud.create(ingredient_create)
            # 增加维护region和food关系表的数据
            await region_food_relation_crud.set_or_add_region_food_relation(region_id=ingredient_temp.region_id,food_id=ingredient_temp.id,is_food=False)

            ingredient_result = Ingredients.model_validate(ingredient_temp)
            logger.info(f"===create_ingredient_service 创建的数据: {ingredient_result}===")
            return ingredient_result
        except Exception as e:
            logger.error(f"===create_ingredient_service 出现错误，内容：{e}===")
            raise
    #更新食材信息
    async def update_ingredient_service(self, ingredient_update: IngredientsUpdate) -> Ingredients:
        logger.info("===update_ingredient_service 开始更新食材信息===")
        try:
            before_update_ingredient=await ingredient_crud.get(id=ingredient_update.id)
            ingredient_temp = await ingredient_crud.update(id=ingredient_update.id, obj_in=ingredient_update)
            # 增加维护region和food关系表的数据
            await region_food_relation_crud.delete_region_food_relation(region_id=before_update_ingredient.region_id,
                                                                            food_id=ingredient_temp.id, is_food=False)
            await region_food_relation_crud.set_or_add_region_food_relation(region_id=ingredient_temp.region_id,
                                                                      food_id=ingredient_temp.id, is_food=False)
            ingredient_result = Ingredients.model_validate(ingredient_temp)
            logger.info(f"===update_ingredient_service 更新的数据: {ingredient_result}===")
            return ingredient_result
        except Exception as e:
            logger.error(f"===update_ingredient_service 出现错误，内容：{e}===")
            raise
    #删除食材信息
    async def delete_ingredient_by_id(self,ingredient_id:int) -> bool:
        logger.info("===delete_ingredient_by_id 开始删除食材信息===")
        try:
            ingredient_temp=await ingredient_crud.get(id=ingredient_id)
            # 增加维护region和food关系表的数据
            await region_food_relation_crud.delete_region_food_relation(region_id=ingredient_temp.region_id,food_id=ingredient_temp.id,is_food=False)

            delete_result=await ingredient_crud.delete(ingredient_id)
            if delete_result is True:
                logger.info(f"===delete_ingredient_by_id 成功删除id为: {ingredient_id}->的数据===")
            else:
                logger.info(f"===delete_ingredient_by_id 失败删除id为: {ingredient_id}->的数据===")
            return delete_result
        except Exception as e:
            logger.error(f"===delete_ingredient_by_id 出现错误{e}===")
            raise
    #分页查询问卷信息
    async def get_questionnaire_by_page(self,page:int,page_size:int,filters:dict | None) -> dict:
        logger.info("===get_questionnaire_by_page 开始分页查询食物信息===")
        try:
            questionnaire_model=await questionnaire_crud.get_questionnaire_by_page(page=page,page_size=page_size,filters=filters)
            questionnaire_schema=[Questionnaire.model_validate(r) for r in questionnaire_model]
            if filters:
                total = await questionnaire_crud.filter_questionnaire_total(filters=filters)
            else:
                total = await questionnaire_crud.questionnaire_total()

            if total is None:total=0
            logger.info(f"===get_questionnaire_by_page 食材总数:{total}===")
            logger.info(f"===get_questionnaire_by_page 查询食材数据: {questionnaire_schema}===")
            return {"questionnaire":questionnaire_schema,"total":total}
        except Exception as e:
            logger.error(f"===get_questionnaire_by_page 出现错误，内容：{e}===")
            raise
    #创建问卷信息
    async def create_questionnaire_service(self, questionnaire_create: QuestionnaireCreate) -> Questionnaire:
        logger.info("===create_questionnaire_service 开始创建问卷信息===")
        try:
            questionnaire_temp = await questionnaire_crud.create(questionnaire_create)
            questionnaire_result = Questionnaire.model_validate(questionnaire_temp)
            logger.info(f"===create_questionnaire_service 创建的数据: {questionnaire_result}===")
            return questionnaire_result
        except Exception as e:
            logger.error(f"===create_questionnaire_service 出现错误，内容：{e}===")
            raise
    #更新问卷信息
    async def update_questionnaire_service(self, questionnaire_update: QuestionnaireUpdate) -> Questionnaire:
        logger.info("===update_questionnaire_service 开始更新问卷信息===")
        try:
            questionnaire_temp = await questionnaire_crud.update(id=questionnaire_update.id, obj_in=questionnaire_update)
            questionnaire_result = Questionnaire.model_validate(questionnaire_temp)
            logger.info(f"===update_questionnaire_service 更新的数据: {questionnaire_result}===")
            return questionnaire_result
        except Exception as e:
            logger.error(f"===update_questionnaire_service 出现错误，内容：{e}===")
            raise
    #删除问卷信息
    async def delete_questionnaire_by_id(self,questionnaire_id:int) -> bool:
        logger.info("===delete_questionnaire_by_id 开始删除食材信息===")
        try:
            delete_result=await questionnaire_crud.delete(questionnaire_id)
            if delete_result is True:
                logger.info(f"===delete_questionnaire_by_id 成功删除id为: {questionnaire_id}->的数据===")
            else:
                logger.info(f"===delete_questionnaire_by_id 失败删除id为: {questionnaire_id}->的数据===")
            return delete_result
        except Exception as e:
            logger.error(f"===delete_questionnaire_by_id 出现错误{e}===")
            raise

food_service = FoodService()
