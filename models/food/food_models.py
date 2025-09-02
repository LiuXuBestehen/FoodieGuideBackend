from datetime import datetime

from tortoise import fields
from tortoise.models import Model

class Foods(Model):
    id = fields.IntField(pk=True)
    name = fields.CharField(max_length=100,null=False)
    description = fields.TextField(null=True)
    category=fields.CharField(max_length=20,null=True)
    region_name=fields.CharField(max_length=50,null=True)
    region_id=fields.IntField(null=False)
    taste=fields.CharField(max_length=255,null=True)
    ingredients=fields.TextField(null=True)
    image_url=fields.TextField(null=True)
    created_at=fields.DatetimeField(null=True,default=datetime.now())

    class Meta:
        table = "foods"


class Ingredients(Model):
    id = fields.IntField(pk=True)
    name = fields.CharField(max_length=255,null=False)
    region_name=fields.CharField(max_length=50,null=False)
    region_id=fields.IntField(null=False)
    taste=fields.CharField(max_length=255,null=True)
    attribute=fields.CharField(max_length=10,null=False)
    effect=fields.TextField(null=True)
    image_url = fields.TextField(null=True)

    class Meta:
        table = "ingredients"

class Questionnaire(Model):
    id = fields.IntField(pk=True)
    title=fields.TextField(null=False)
    answer=fields.TextField(null=False)
    right_answer=fields.CharField(max_length=2,null=False)

    class Meta:
        table = "questionnaire"

class TheCharts(Model):
    id=fields.IntField(pk=True)
    food_id=fields.IntField(null=False)
    user_collect_sum=fields.BigIntField(null=False)

    class Meta:
        table = "the_charts"