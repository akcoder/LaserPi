import json
from collections import namedtuple
from PySide import QtCore

def _json_object_hook(d): return namedtuple('X', d.keys())(*d.values())
def json2obj(file): return json.load(file, object_hook=_json_object_hook)

class Settings(QtCore.QObject):
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

    def __get_json(self) -> str:
        with open('config.json', 'r') as myfile:
            return myfile.read()

    json = QtCore.Property(str, __get_json, constant=True)