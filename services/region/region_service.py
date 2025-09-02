from typing import List, Dict, Any

from fastapi import HTTPException
from schemas.region.region_schemas import Regions,RegionFoodRelationCreateOrUpdate
from schemas.food.food_schemas import Food
from crud.region.region_crud import region_crud,region_food_relation_crud
import logging

logger = logging.getLogger(__name__)


class RegionService:
    """
    获取全部区域数据
    Return:
        List[Regions],包含region的list列表
    """
    async def get_regions(self) -> List[Regions]:
        logger.info("===get_regions 开始查询全部城市信息===")
        try:
            # 1 查库拿到全部region信息
            regions_model=await region_crud.get_regions()
            # 2 将region的model转换成schema格式
            regions_schema=[Regions.model_validate(r) for r in regions_model]
            logger.info(f"get_regions 查询到的地区数据: {regions_schema}")
            return regions_schema
        except Exception as e:
            logger.error(f"===get_regions 出现错误,内容：{e}===")
            raise HTTPException(status_code=500, detail=str(e))

    """
    获取全部食物及对应地区信息
    Return:
    Dict：包含regions和foods的字典
    """
    async def get_regions_foods(self)->Dict[str,Any]:
        logger.info("===get_regions_foods 开始查询全部食物及对应地区信息===")
        try:
            # 1 查库拿到全部region和food信息
            regions_foods_model=await region_food_relation_crud.get_all_region_food()
            logger.info(f"get_regions_foods 查询到的地区数据: {regions_foods_model}")
            # 2 将regions_foods_model的region和food分别转换成对应的schema
            regions=[RegionFoodRelationCreateOrUpdate.model_validate(r) for r in regions_foods_model.get("regions",[])]
            foods = [Food.model_validate(f) for f in regions_foods_model.get("foods",[])]
            return {
            "regions": regions,
            "foods": foods
        }
        except Exception as e:
            logger.error(f"===get_regions_foods 出现错误，内容：{e}===")
            raise

region_service = RegionService()
