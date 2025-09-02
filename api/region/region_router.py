from fastapi import APIRouter
from services.region.region_service import region_service
from schemas.base.base_response_model import BaseResponseModel
import logging

logger=logging.getLogger(__name__)

router = APIRouter()

# 查询全部地区
@router.get("/getRegions",response_model=BaseResponseModel)
async def get_regions():
    regions = await region_service.get_regions()
    return BaseResponseModel.success_request(data=regions)

# 获取全部食物及对应地区信息
@router.get("/getRegionsAndFoods",response_model=BaseResponseModel)
async def get_regions_and_foods():
    regions_and_foods=await region_service.get_regions_foods()
    return BaseResponseModel.success_request(data=regions_and_foods)