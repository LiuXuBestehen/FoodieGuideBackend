# 数据模型
from pydantic import BaseModel

class FoodCreate(BaseModel):
    name : str
    description : str | None
    category : str | None
    region_name : str | None
    region_id : int
    taste : str | None
    ingredients : str | None
    image_url : str | None

class FoodUpdate(BaseModel):
    id : int
    name : str
    description : str | None
    category : str | None
    region_name : str | None
    region_id : int
    taste : str | None
    ingredients : str | None
    image_url : str | None


class Food(BaseModel):
    id : int
    name : str
    description : str | None
    category : str | None
    region_name : str | None
    region_id : int
    taste : str | None
    ingredients : str | None
    image_url : str | None

    model_config = {
        "from_attributes": True,  # 必须加，支持 ORM 对象转换
    }

class IngredientsCreate(BaseModel):
    name : str
    region_name : str
    region_id : int
    taste : str | None
    attribute : str | None
    effect : str
    image_url: str | None

class IngredientsUpdate(BaseModel):
    id : int
    name : str
    region_name : str
    region_id : int
    taste : str | None
    attribute : str | None
    effect : str
    image_url: str | None


class Ingredients(BaseModel):
    id : int
    name : str
    region_name : str
    region_id : int
    taste : str | None
    attribute : str | None
    effect : str
    image_url: str | None

    model_config = {
        "from_attributes": True,  # 必须加，支持 ORM 对象转换
    }

class QuestionnaireCreate(BaseModel):
    title : str | None
    answer : str | None
    right_answer : str | None

class QuestionnaireUpdate(BaseModel):
    id : int
    title : str | None
    answer : str | None
    right_answer : str | None


class Questionnaire(BaseModel):
    id : int
    title : str | None
    answer : str | None
    right_answer : str | None

    model_config = {
        "from_attributes": True,  # 必须加，支持 ORM 对象转换
    }

class TheChartsCreateOrUpdate(BaseModel):
    food_id :int
    user_collect_sum :int



