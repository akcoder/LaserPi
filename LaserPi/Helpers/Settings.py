import json

class Settings(object):
    """Settings"""
    __settings = json.load(open('config.json'))

    @classmethod
    def get(cls, section: str, key: str = None) -> str:
        if section in cls.__settings:
            if key == None:
                return cls.__settings[section]

            if key in cls.__settings[section]:
                return cls.__settings[section][key]

        return None
