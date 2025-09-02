from tortoise import fields
from tortoise.models import Model

class Regions(Model):
    id = fields.IntField(pk=True)
    name = fields.CharField(max_length=50,null=False)
    province_id = fields.IntField(null=False)
    city_level=fields.IntField(null=False)

    class Meta:
        table = "regions"

class RegionFoodRelation(Model):
    id = fields.IntField(pk=True)
    region_id =fields.IntField(null=False)
    region_name = fields.CharField(max_length=255,null=False)
    region_lng =fields.FloatField(null=False)
    region_lat = fields.FloatField(null=False)
    food_ids = fields.TextField()
    ingredient_ids = fields.TextField()

    class Meta:
        table = "region_food_relation"