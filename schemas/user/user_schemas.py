# 数据模型
from pydantic import BaseModel, EmailStr


class UserCreate(BaseModel):
    username: str
    email: EmailStr
    password: str

class UserLogin(BaseModel):
    email: str
    password: str

class User(BaseModel):
    id: int
    username: str
    email: str
    phone_number: str | None
    description:str | None
    constitution:str | None
    role:str | None

    model_config = {
        "from_attributes": True,  # 必须加，支持 ORM 对象转换
    }

class UserUpdate(BaseModel):
    phone_number: str | None
    description:str| None
    constitution:str| None

class Token(BaseModel):
    access_token: str
    token_type: str

class UserCollectFoodCreateOrUpdate(BaseModel):
    user_id: int
    food_id: int