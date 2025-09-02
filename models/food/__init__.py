# food/__init__.py
from .food_models import Foods,  Ingredients, Questionnaire, TheCharts

# 这行很重要，让 Tortoise 能找到模型
__all__ = ["Foods", "Ingredients", "Questionnaire", "TheCharts"]