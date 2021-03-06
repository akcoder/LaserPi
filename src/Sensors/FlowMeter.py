import logging
import sys
import time
from threading import Thread
from Helpers import PerpetualTimer
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

    __logger = logging.getLogger(__name__)
    def __init__(self, config):
        self.__logger.info('Setting up %s' % __name__)

        self.__count = 0
        self.__flow_rate = -255
        self.__time_start = time.time()
        self.__time_delta = 0

        #The id can be anything. Right now its 'foo'
        #In theory we could have multiple flow meters...

        meter = config[0]
        self.__id = config._fields[0]
        self.__pin = meter.pin
        self.__correction_factor = meter.correction_factor

        conversion = self.__conversion[meter.units]
        if conversion == None:
            conversion = self.__conversion[0]

        self.__multiplier = conversion

        if sys.platform == 'linux':
            self.__gpio_thread = Thread(target=self.__setup_gpio)
            self.__gpio_thread.setDaemon(1)
            self.__gpio_thread.start()

    def __setup_gpio(self) -> None:
        self.__logger.info("Setting up FlowMeter GPIO(%d)" % self.__pin)
        GPIO.setup(self.__pin, GPIO.IN, pull_up_down = GPIO.PUD_DOWN)
        GPIO.add_event_detect(self.__pin, GPIO.RISING, callback=self.count_pulse, bouncetime=1)

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
                Event('flow_changed', self.__id, flow_rate)

            self.__count = 0
            self.__time_delta = 0
            self.__time_start = time.time()
