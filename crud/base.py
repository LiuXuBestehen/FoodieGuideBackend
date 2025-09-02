from typing import Type, TypeVar, Generic, List, Optional, Dict, Any
from tortoise.models import Model
from pydantic import BaseModel
import logging

ModelType = TypeVar("ModelType", bound=Model)
CreateSchemaType = TypeVar("CreateSchemaType", bound=BaseModel)
UpdateSchemaType = TypeVar("UpdateSchemaType", bound=BaseModel)

logger = logging.getLogger(__name__)

class CRUDBase(Generic[ModelType, CreateSchemaType, UpdateSchemaType]):
    def __init__(self, model: Type[ModelType]):
        self.model = model

    async def get(self, id: int) -> Optional[ModelType]:
        return await self.model.get_or_none(id=id)

    async def get_multi(
            self,
            skip: int = 0,
            limit: int = 100,
            filters: Dict[str, Any] = None
    ) -> List[ModelType]:
        query = self.model.all()
        if filters:
            query = query.filter(**filters)
        return await query.offset(skip).limit(limit)

    async def create(self, obj_in: CreateSchemaType) -> ModelType:
            obj_data = obj_in.model_dump()
            return await self.model.create(**obj_data)

    async def update(self, id: int, obj_in: UpdateSchemaType) -> Optional[ModelType]:
        obj = await self.get(id)
        if not obj:
            return None

        update_data = obj_in.dict(exclude_unset=True)
        await obj.update_from_dict(update_data)
        await obj.save()
        return obj

    async def delete(self, id: int) -> bool:
        obj = await self.get(id)
        if obj:
            await obj.delete()
            return True
        return False