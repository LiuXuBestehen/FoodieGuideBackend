
# 源字符串是,分割，从源字符串中，删除target字符串后，返回剩余字符串
async def remove_target_from_source(source_str: str, target: str) -> str:
    names = [n.strip() for n in source_str.split(",")]
    return ",".join([n for n in names if n != target])
