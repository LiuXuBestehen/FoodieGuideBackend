from typing import List, Set
from crud.base import CRUDBase
from models.food import Foods, Ingredients, Questionnaire, TheCharts
from schemas.food.food_schemas import FoodCreate, FoodUpdate, IngredientsCreate, IngredientsUpdate, QuestionnaireCreate, \
    QuestionnaireUpdate, TheChartsCreateOrUpdate


class FoodCRUD(CRUDBase[Foods, FoodCreate,FoodUpdate]):

    """
    分页获取美食信息
    """
    async def get_foods_by_page(self,page,page_size,filters) -> List[Foods]:
        return await self.get_multi(skip=(page - 1) * page_size,limit=page_size,filters=filters)

    """
    获取系统的全部美食个数
    """
    async def foods_total(self) -> int:
        return await self.model.all().count()

    """
    获取有条件过滤的美食个数
    """
    async def filter_food_total(self,filters) -> int:
        return await self.model.filter(**filters).count()

    """
    获取全部美食的分类信息
    """
    async def get_food_categories(self) -> Set[str]:
        foods=await self.model.all()
        categories = set[str]([f.category for f in foods])
        return categories

class IngredientCRUD(CRUDBase[Ingredients, IngredientsCreate,IngredientsUpdate]):
    """
    分页获取食材信息
    """
    async def get_ingredient_by_page(self,page,page_size,filters) -> List[Ingredients]:
        return await self.get_multi(skip=(page - 1) * page_size,limit=page_size,filters=filters)

    """
    获取全部食材个数
    """
    async def ingredient_total(self) -> int:
        return await self.model.all().count()

    """
    获取过滤条件的食材个数
    """
    async def filter_ingredient_total(self,filters) -> int:
        return await self.model.filter(**filters).count()


class QuestionnaireCRUD(CRUDBase[Questionnaire, QuestionnaireCreate,QuestionnaireUpdate]):
    """
    分页获取问卷信息
    """
    async def get_questionnaire_by_page(self,page,page_size,filters) -> List[Questionnaire]:
        return await self.get_multi(skip=(page - 1) * page_size,limit=page_size,filters=filters)

    """
    获取全部问卷个数
    """
    async def questionnaire_total(self) -> int:
        return await self.model.all().count()

    """
    获取过滤条件问卷个数
    """
    async def filter_questionnaire_total(self,filters) -> int:
        return await self.model.filter(**filters).count()

class TheChartsCrud(CRUDBase[TheCharts,TheChartsCreateOrUpdate,TheChartsCreateOrUpdate]):
    """
        收藏美食增加排行榜个数
    """
    async def add_the_charts(self, food_id: int) -> bool:
        # 1.通过food_id查询the_charts
        the_charts = await  self.model.filter(food_id=food_id).first()
        # 2.没有查到，新建一条数据，返回True
        if not the_charts:
            await self.create(obj_in=TheChartsCreateOrUpdate(food_id=food_id,user_collect_sum=1))
            return True
        # 3.有查到，将收藏用户数+1，返回True
        else:
            await self.update(id=the_charts.id,
                              obj_in=TheChartsCreateOrUpdate(
                                  food_id=food_id,
                                  user_collect_sum=the_charts.user_collect_sum+1))
            return True
    """
        移除收藏美食减少排行榜个数
    """
    async def delete_the_charts(self, food_id: int) -> bool:
     # 1.通过food_id查询the_charts
     the_charts = await  self.model.filter(food_id=food_id).first()
     # 2.没有查到，返回True
     if not the_charts:
         return True
     # 3.有查到，将收藏用户数-1，返回True.当用户数为0时,删除记录
     else:
         if the_charts.user_collect_sum-1==0:
             await self.delete(id=the_charts.id)
             return True
         else:
             await self.update(id=the_charts.id,
                               obj_in=TheChartsCreateOrUpdate(
                                   food_id=food_id,
                                   user_collect_sum=the_charts.user_collect_sum - 1))
             return True

    """
    获取排行榜前N个美食的信息
    Return:List[int],包含前num个的the_charts信息
    """
    async def get_foods_ids_from_the_charts(self,num:int) -> List[int]:
        #先降序查询the_charts,再取前num个
        the_charts_index_num=await self.model.all().order_by('-user_collect_sum').limit(num)
        # 提取前num个的food_id,形成列表返回
        return [t.food_id for t in the_charts_index_num ]

    """
    通过food_id移除排行榜记录
    """
    async def remove_the_charts(self,food_id: int) -> bool:
        obj = await self.model.get_or_none(food_id=food_id)
        if obj:
            await obj.delete()
            return True
        return False

food_crud = FoodCRUD(Foods)
ingredient_crud = IngredientCRUD(Ingredients)
questionnaire_crud = QuestionnaireCRUD(Questionnaire)
the_charts_crud = TheChartsCrud(TheCharts)

