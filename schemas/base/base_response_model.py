from pydantic import BaseModel

class BaseResponseModel(BaseModel):
    message: str | None
    status: int
    success: bool
    data: object | None

    @staticmethod
    def success_request(data=None):
        return BaseResponseModel(message=None,status=200,success=True,data=data)
