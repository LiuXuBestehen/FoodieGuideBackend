import os
from dotenv import load_dotenv

load_dotenv()

class Config:
    ENV = os.getenv("ENV", "production")
    DEBUG = os.getenv("DEBUG", "False") == "True"
    PORT = int(os.getenv("PORT", "8000"))

    SECRET_KEY = os.getenv("SECRET_KEY")
    ALGORITHM=os.getenv("ALGORITHM","HS256")
    ACCESS_TOKEN_EXPIRE_MINUTES=int(os.getenv("ACCESS_TOKEN_EXPIRE_MINUTES", "1440"))

    ORIGINS=[o.strip() for o in os.getenv("CORS_ORIGINS","").split(",") if o.strip()]
    TORTOISE_ORM={
    "connections": {
        # "default": "mysql://root:root@localhost:3306/foodie_guide",
        "default": {
            "engine": "tortoise.backends.mysql",
            "credentials": {
                "host": os.getenv("DB_HOST", "localhost"),
                "port": int(os.getenv("DB_PORT", 3306)),
                "user": os.getenv("DB_USER", "root"),
                "password": os.getenv("DB_PASSWORD", ""),
                "database": os.getenv("DB_NAME", "mydb"),
            }
        }
    },
    "apps": {
        "models": {
            "models": ["models.food","models.region","models.user"],
            "default_connection": "default",
        }
     }
    }