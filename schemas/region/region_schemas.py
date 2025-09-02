from pydantic import BaseModel

class Regions(BaseModel):
    id:int
    name:str
    province_id:int
    city_level:int

    model_config = {
    "from_attributes": True,  # 必须加，支持 ORM 对象转换
    }



class RegionCreateOrUpdate(BaseModel):
    name:str
    province_id:int
    city_level:int

class RegionFoodRelationCreateOrUpdate(BaseModel):
    region_id:int
    region_name:str
    region_lng:float
    region_lat:float
    food_ids:str
    ingredient_ids:str

    model_config = {
        "from_attributes": True,  # 必须加，支持 ORM 对象转换
    }



