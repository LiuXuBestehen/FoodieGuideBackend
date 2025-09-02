from typing import List, Dict, Any
from crud.base import CRUDBase
from crud.food.food_crud import food_crud
from models.region import Regions,RegionFoodRelation
from schemas.region.region_schemas import RegionCreateOrUpdate,RegionFoodRelationCreateOrUpdate
import logging
from utils.str_util import remove_target_from_source

logger = logging.getLogger(__name__)

class RegionCRUD(CRUDBase[Regions, RegionCreateOrUpdate,RegionCreateOrUpdate]):
    """
         获取全部地区信息，上限1000条

          Returns:
            List[Regions], 包含region的list列表
    """
    async def get_regions(self) -> List[Regions]:
        return await self.get_multi(limit=1000)

    """
         设置或添加区域和美食关系

          Returns:
            bool：成功True，失败False
    """
    async def get_region_by_name(self, name: str) -> Regions:
        logger.info(f"get_region_by_name: {name}")
        return await self.model.get_or_none(name=name)

class RegionFoodRelationCRUD(CRUDBase[RegionFoodRelation, RegionFoodRelationCreateOrUpdate,RegionFoodRelationCreateOrUpdate]):
    """
     设置或添加区域和美食关系

      Returns:
        bool：成功True，失败False
    """
    async def set_or_add_region_food_relation(self,region_id:int,food_id:str,is_food:bool) -> bool:
        # 1 先根据regionId取到对应的记录
        region_food_relation=await self.model.get_or_none(region_id=region_id)
        if region_food_relation is None:
            logger.error(f"===id为 {region_id} 的地区未找到===")
            return False
        # 2 判断是放到foods还是ingredients中
        if is_food :
            # 2.1 根据food_ids字段已有值判断是新增，还是更新
            if region_food_relation.food_ids=="":
                region_food_relation.food_ids=str(food_id)
            else:
                region_food_relation.food_ids+=f",{food_id}"
        else:
            # 2.2 根据ingredient_ids字段已有值判断是新增，还是更新
            if region_food_relation.ingredient_ids == "":
                region_food_relation.ingredient_ids = str(food_id)
            else:
                region_food_relation.ingredient_ids += f",{food_id}"
        await region_food_relation.save()
        return True

    """
       删除区域和食物的关系

       Returns:
           bool：成功True，失败False
    """
    async def delete_region_food_relation(self,region_id:int,food_id:str,is_food:bool) -> bool:
        # 1 先根据regionId取到对应的记录
        region_food_relation=await self.model.get_or_none(region_id=region_id)
        if region_food_relation is None:
            logger.error(f"===id为 {region_id} 的地区未找到===")
            return False
        # 2 判断是删除foods还是ingredients
        if is_food :
            # 2.1 删除food数据
            if region_food_relation.food_ids=="": return True
            remove_result=await remove_target_from_source(region_food_relation.food_ids,str(food_id))
            region_food_relation.food_ids=remove_result
        else:
            #2.2 删除ingredients数据
            if region_food_relation.ingredient_ids == "": return True
            region_food_relation.ingredient_ids =await remove_target_from_source(region_food_relation.ingredient_ids, str(food_id))
        await region_food_relation.save()
        return True

    """
    获取区域和美食数据

    Returns:
        Dict: 包含regions和foods的字典
    """
    async def get_all_region_food(self)->Dict[str,Any]:
        # 1. 获取food_ids不为空的region_food记录
        regions = await self.model.filter(
            food_ids__not=""
        ).filter(
            food_ids__isnull=False
        ).all()

        if not regions:
            return {"regions": [], "foods": []}

        # 2. 收集所有food_ids
        all_food_ids = set()
        for region in regions:
            if region.food_ids:
                # 分割food_ids字符串，过滤空值
                food_id_list = [
                    int(food_id.strip())
                    for food_id in region.food_ids.split(',')
                    if food_id.strip().isdigit()
                ]
                all_food_ids.update(food_id_list)

        # 3. 根据food_ids查询food表
        foods = []
        if all_food_ids:
            foods = await food_crud.model.filter(id__in=list(all_food_ids)).all()

        return {
            "regions": regions,
            "foods": foods
        }


region_crud = RegionCRUD(Regions)
region_food_relation_crud= RegionFoodRelationCRUD(RegionFoodRelation)
