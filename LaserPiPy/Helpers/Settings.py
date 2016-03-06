import json
from collections import namedtuple

def _json_object_hook(d): return namedtuple('X', d.keys())(*d.values())
def json2obj(file): return json.load(file, object_hook=_json_object_hook)

class Settings():
    """Settings"""
    instance = json2obj(open('config.json'))

    @classmethod
    def get(cls, section: str, key: str = None) -> str:
        if section in cls.__settings:
            if key == None:
                return cls.__settings[section]

            if key in cls.__settings[section]:
                return cls.__settings[section][key]

        return None
