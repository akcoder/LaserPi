import os
import timefrom Helpers import Settings
from Helpers.PerpetualTimer import PerpetualTimer
from Helpers.Observer import Event

class Temperature(object):
    """Reads temperature data"""

    __base_dir = '/sys/bus/w1/devices/'
    __sensors = Settings.get('sensors', 'temperature')
    __units = Settings.get('units', 'temperature')
    __mapper = {
        "metric": 0,
        "imperial": 1,
        "kelvin": 2
    }

    def __init__(self, **kwargs):
        self.__sensor_temp = {}
        #Set all the temp values to -255 so we can do change detection
        for k,v in self.__sensors.items():
            self.__sensor_temp[k] = -255

    def start(self) -> None:
        self.__sensor_timer = PerpetualTimer(0.25, self.__poll_sensors)
        self.__sensor_timer.start()

    def stop(self) -> None:
        if self.__sensor_timer is not None:
            print("Canceling sensor timer")
            self.__sensor_timer.cancel()

    def __poll_sensors(self) -> None:
        for key,v in self.__sensors.items():
            temp = self.read(key)

            if temp != self.__sensor_temp[key]:
                self.__sensor_temp[key] = temp
                Event('temp_changed', key, temp)

    def read(self, name: str) -> float:
        index = self.__mapper.get(self.__units)
        temp = self.__read_temp(self.__sensors[name])[index]

        if temp is not None:
            return round(temp, 1)

        return -255

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