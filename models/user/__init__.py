# food/__init__.py
from .user_models import User, UserCollectFood

# 这行很重要，让 Tortoise 能找到模型
__all__ = ["User", "UserCollectFood"]