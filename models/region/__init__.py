# food/__init__.py
from .region_models import RegionFoodRelation, Regions

# 这行很重要，让 Tortoise 能找到模型
__all__ = ["RegionFoodRelation", "Regions"]