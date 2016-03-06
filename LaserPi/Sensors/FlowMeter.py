import sys
import time

if sys.platform == 'linux':
    import RPi.GPIO as GPIO

class FlowMeter(object):
    """Flow Meter"""
    def __init__(self):
        self.__count = 0
        self.__time_start = time.time()
        self.__time_delta = 0

        GPIO.setup(FLOW_SENSOR, GPIO.IN, pull_up_down = GPIO.PUD_DOWN)

    def countPulse(self, channel: int):
        self.__count = self.__count+1
        self.__time_delta = (time.time() - self.__time_start)    

        if self.__time_delta >= 10.0:
            flow = int(self.__count / 75)
            flow = str(flow)
            self.__count = 0
            self.__time_delta = 0
            self.__time_start = time.time()
