import json
from collections import namedtuple

def _json_object_hook(d): return namedtuple('X', d.keys())(*d.values())
def json2obj(file): return json.load(file, object_hook=_json_object_hook)

class Settings():
    """Settings"""
    instance = json2obj(open('config.json'))
