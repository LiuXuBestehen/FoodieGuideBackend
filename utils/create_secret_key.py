import secrets
#必要时运行一次就行，如果更新Key，用之前key创建的token就会失效
print(secrets.token_urlsafe(32))
