import sys
import os
import time
import logging
import random
from Helpers.PerpetualTimer import PerpetualTimer
from Helpers.Observer import Event
from Sensors import ISensor

class Temperature(ISensor):
    """Reads temperature data"""

    __base_dir = '/sys/bus/w1/devices/'
    __mapper = {
        "metric": 0,
        "imperial": 1,
        "kelvin": 2
    }
    __updateInterval = 0.25 if sys.platform == 'linux' else 2
    __logger = logging.getLogger(__name__)
    def __init__(self, config):
        self.__logger.info('Setting up %s', __name__)
        self.__sensors = config
        self.__temp_sensors = {}

        #Set all the temp values to -255 so we can do change detection
        for key in self.__sensors._fields:
            self.__temp_sensors[key] = -255

    def start(self) -> None:
        self.__sensor_timer = PerpetualTimer(self.__updateInterval, self.__poll_sensors)
        self.__sensor_timer.start()

    def stop(self) -> None:
        if self.__sensor_timer is not None:
            self.__logger.info("Canceling sensor timer")
            self.__sensor_timer.cancel()

    def __poll_sensors(self) -> None:
        for key in self.__sensors._fields:
            temp = self.read(key)

            if temp != self.__temp_sensors[key]:
                self.__temp_sensors[key] = temp
                Event('temp_changed', key, temp)

    def read(self, name: str) -> float:
        sensor = getattr(self.__sensors, name)
        index = self.__mapper.get(sensor.units)
        if index == None:
            index = 0

        temp = self.__read_temp(sensor.id)[index]

        if temp is not None:
            return round(temp, 1)

        return round(random.random() * 30, 1)

    @classmethod
    def __read_temp_raw(cls, id: str) -> []:
        file = os.path.join(cls.__base_dir, id, 'w1_slave')

        if not os.path.exists(file):
            return []

        with open(file, 'r') as f:
            lines = f.readlines()
        return lines

    @classmethod
    def __read_temp(cls, id: str):
        lines = cls.__read_temp_raw(id)

        if not len(lines):
            return (None, None, None)

        while lines[0].strip()[-3:] != 'YES':
            time.sleep(0.2)
            lines = cls.__read_temp_raw()
        equals_pos = lines[1].find('t=')

        if equals_pos != -1:
            temp_string = lines[1][equals_pos+2:]
            temp_c = float(temp_string) / 1000.0
            temp_f = temp_c * 9.0 / 5.0 + 32.0
            temp_k = temp_c + 273.15
            return (temp_c, temp_f, temp_k)
