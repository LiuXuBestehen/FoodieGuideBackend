from fastapi.routing import APIRouter
from services.other_service import other_service
from schemas.base.base_response_model import  BaseResponseModel

router = APIRouter()


@router.get(path="/stats", response_model=BaseResponseModel)
async def get_index_stats():
    result=await other_service.index_stats()
    return BaseResponseModel.success_request(data=result)



