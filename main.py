from fastapi import FastAPI, Request, HTTPException
from fastapi.responses import JSONResponse
from tortoise.contrib.fastapi import register_tortoise
from config import Config
import logging
from api.region import region_router
from api.user import user_router
from api.food import food_router
from api import other_router
from fastapi.middleware.cors import CORSMiddleware

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
# 增加监听tortoise日志
logging.getLogger("tortoise").setLevel(logging.DEBUG)
logger = logging.getLogger(__name__)

# FastAPI app实例
app = FastAPI()

# 配置CORS中间件
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # 允许的源，可以替换为特定域名，例如 ["http://localhost:8080"]
    allow_credentials=True,
    allow_methods=["*"],  # 允许的请求方法（GET, POST, PUT, DELETE等）
    allow_headers=["*"],  # 允许的请求头
)

#
app.include_router(region_router.router,prefix="/region",tags=["region"])
app.include_router(user_router.router,prefix="/user",tags=["user"])
app.include_router(food_router.router,prefix="/food",tags=["food"])

app.include_router(other_router.router)

# 注册tortoise,这个函数已经自动加上了startup和shutdown的周期清理
register_tortoise(
    app,
    config=Config.TORTOISE_ORM,
    generate_schemas=False,
    add_exception_handlers=True,
)

@app.exception_handler(HTTPException)
async def custom_http_exception_handler(request: Request, exc: HTTPException):
    return JSONResponse(
        status_code=exc.status_code,
        content={
            "status": exc.status_code,
            "message": str(exc.detail),
            "success": False,
            "data": None
        }
    )

