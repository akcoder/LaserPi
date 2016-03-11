import sys
import time
from threading import Thread
from Helpers import Settings, PerpetualTimer
from Helpers.Observer import Event
from Sensors import ISensor

if sys.platform == 'linux':
    import RPi.GPIO as GPIO

class FlowMeter(ISensor):
    """Reads flow data from the YF-S201"""

    __conversion = {
        "metric": 1,
        "imperial": 0.26417287472922
    }

    def __init__(self):
        print('Setting up %s' % __name__)

        self.__count = 0
        self.__flow_rate = -255
        self.__time_start = time.time()
        self.__time_delta = 0
        self.__correction_factor = Settings.instance.sensors.flow.correction_factor
        self.__multiplier = self.__conversion[Settings.instance.units.flow]

        if sys.platform == 'linux':
            self.__gpio_thread = Thread(target=self.__setup_gpio)
            self.__gpio_thread.setDaemon(1)
            self.__gpio_thread.start()

    def __setup_gpio(self) -> None:
        pin = Settings.instance.pins.input.flow
        print("Setting up FlowMeter GPIO(%d)" % pin)
        GPIO.setup(pin, GPIO.IN, pull_up_down = GPIO.PUD_DOWN)
        GPIO.add_event_detect(pin, GPIO.RISING, callback=self.count_pulse, bouncetime=1)

    def start(self) -> None:
        pass

    def stop(self) -> None:
        pass

    def count_pulse(self, channel: int):
        self.__count = self.__count+1
        self.__time_delta = (time.time() - self.__time_start)    

        if self.__time_delta >= 1.0:
            #Pulse frequency (Hz) = 7.5Q, Q is flow rate in L/min. (Results in +/- 3% range)
            liters_per_min = self.__count / self.__correction_factor
            liters_per_min = liters_per_min

            if self.__flow_rate != liters_per_min:
                #Convert to imperial if need be
                flow_rate = round(liters_per_min * self.__multiplier, 1)
                self.__flow_rate = flow_rate
                Event('flow_changed', flow_rate)

            self.__count = 0
            self.__time_delta = 0
            self.__time_start = time.time()
