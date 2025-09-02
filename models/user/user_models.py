from tortoise import fields
from tortoise.models import Model

class User(Model):
    id = fields.IntField(pk=True)
    username=fields.CharField(max_length=255,null=False)
    password = fields.CharField(max_length=255,null=False)
    email = fields.CharField(max_length=255,null=False)
    phone_number = fields.CharField(max_length=30,null=True)
    description = fields.CharField(max_length=255,null=True)
    constitution = fields.CharField(max_length=100,null=True)
    role=fields.CharField(max_length=10,default="user")

    class Meta:
        table = "user"


class UserCollectFood(Model):
    id = fields.IntField(pk=True)
    user_id=fields.IntField(null=False)
    food_id=fields.IntField(null=False)

    class Meta:
        table = "user_collect_food"