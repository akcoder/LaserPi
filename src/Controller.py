"""The glue between the view and viewModel"""

import os
import sys
import threading
from threading import Thread, Timer
from PySide import QtCore
from ViewModel import MainViewModel
from Helpers import Settings
from enum import IntEnum
from Helpers.PerpetualTimer import PerpetualTimer
from Helpers.Observer import Observer
from Sensors.SensorFactory import SensorFactory

if sys.platform == 'linux':
    import RPi.GPIO as GPIO

class Controller(Observer):
    """The glue between the view and viewModel"""

    def __init__(self, viewModel: MainViewModel):
        Observer.__init__(self)

        self.__view_model = viewModel
        self.__gpio_is_setup = False
        self.__exhaust_timer = None
        self.__view_model.onChillerChanged.connect(self.chiller_changed)
        self.__view_model.onAirChanged.connect(self.air_changed)
        self.__view_model.onExhaustChanged.connect(self.exhaust_changed)
        self.__view_model.onExitClicked.connect(self.close)
        self.__view_model.onShutdownClicked.connect(self.shutdown)
        self.__sensors = []

        if sys.platform == 'linux':
            self._states = {
                Settings.instance.pins.input.working:GPIO.LOW,
                Settings.instance.pins.input.airTrigger:GPIO.LOW
            }

            self.__gpio_thread = Thread(target=self.__setup_gpio)
            self.__gpio_thread.setDaemon(1)
            self.__gpio_thread.start()

        self.observe('temp_changed', self.handle_temp_changed)
        self.observe('flow_changed', self.handle_flow_changed)

        for key in Settings.instance.sensors._fields:
            config = getattr(Settings.instance.sensors, key)
            sensor = SensorFactory.factory(key, config)
            sensor.start();
            self.__sensors.append(sensor)

    def __del__(self):
        print('Destructor called, cleaning up')
        self.cleanup()

    def __setup_gpio(self) -> None:
        print("Setting up GPIO")
        GPIO.setmode(GPIO.BCM)

        GPIO.setup(Settings.instance.pins.output.exhaust, GPIO.OUT)
        GPIO.setup(Settings.instance.pins.output.chiller, GPIO.OUT)
        GPIO.setup(Settings.instance.pins.output.airOutput, GPIO.OUT)

        GPIO.setup(Settings.instance.pins.input.working, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
        GPIO.add_event_detect(Settings.instance.pins.input.working, GPIO.BOTH, callback=self.working_changed, bouncetime=25)

        GPIO.setup(Settings.instance.pins.input.airTrigger, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
        GPIO.add_event_detect(Settings.instance.pins.input.airTrigger, GPIO.BOTH, callback=self.air_trigger_changed, bouncetime=25)

        self.__gpio_is_setup = True

    def close(self):
        print("Close called")
        self.cleanup()
        print("After cleanup")
        QtCore.QCoreApplication.instance().quit()

        print("OS exit")
        os._exit(0)
        raise SystemExit

    @classmethod
    def shutdown(cls):
        if sys.platform == "linux":
            try:
                command = "/usr/bin/sudo /sbin/shutdown --halt now"
                import subprocess
                process = subprocess.Popen(command.split(), stdout=subprocess.PIPE)
                output = process.communicate()[0]
                print(output)
            except Exception as ex:
                print(ex)
                print("Unable to shutdown")
                sys.exit()
        else:
            sys.exit()

    def cleanup(self):
        print("Cleanup called")

        for sensor in self.__sensors:
            sensor.stop()

        if sys.platform == 'linux' and self.__gpio_is_setup:
            print("Cleaning up GPIO")
            GPIO.cleanup()

    def handle_temp_changed(self, name: str, value: float) -> None:
        self.__view_model.onTemperatureChanged.emit(name, value)
        #print(name, value)

    def handle_flow_changed(self, name: str, value: float) -> None:
        self.__view_model.onFlowRateChanged.emit(name, value)

    def air_changed(self) -> None:
        if sys.platform != 'linux':
            return

        self.set_air_state(GPIO.HIGH if self.__view_model.air else GPIO.LOW)

    @QtCore.Slot()
    def air_trigger_changed(self, channel=None):
        if  GPIO.input(channel) == GPIO.HIGH:
            if  self._states[channel] == GPIO.LOW:
                print("Turning air on because triggered")
                self.__view_model.air = True

            self._states[channel] = GPIO.HIGH
        elif self._states[channel] == GPIO.HIGH and self.__view_model.air:
            print("Turning air off because triggered")
            self.__view_model.air = False
            self._states[channel] = GPIO.LOW

    def set_air_state(self, state):
        self.set_pin_state(Settings.instance.pins.output.airOutput, state)

    def set_pin_state(self, pin: int, state: bool) -> None:
        print("Setting GPIO {0} to {1}".format(pin, "HIGH" if state else "LOW"))
        GPIO.output(pin, GPIO.HIGH if state else GPIO.LOW)

    def working_changed(self, channel):
        if  GPIO.input(channel) == GPIO.HIGH:
            if  self._states[channel] == GPIO.LOW:
                print("Laser is working")
                self.__view_model.working = True
                self.turn_exhaust_on()

                if self.__exhaust_timer is not None:
                    self.__exhaust_timer.cancel()
                    self.__exhaust_timer = None

            self._states[channel] = GPIO.HIGH
        elif self._states[channel] == GPIO.HIGH:
            if self.__view_model.exhaust:
                assert self.__exhaust_timer is None, "Exhaust timer should have been set to null!"

                seconds = Settings.instance.exhaust_time_after_finished
                print("Setting exhaust off timer for %d seconds" % seconds)
                self.__exhaust_timer = Timer(seconds, self.turn_exhaust_off)
                self.__exhaust_timer.start()
                self.__view_model.working = False
            self._states[channel] = GPIO.LOW

    def turn_exhaust_on(self):
        print("Turning exhaust fan on")
        self.__view_model.exhaust = True
        self.set_pin_state(Settings.instance.pins.output.exhaust, GPIO.HIGH)

    def turn_exhaust_off(self):
        print("Turning exhaust fan off")
        self.__view_model.exhaust = False
        self.__exhaust_timer = None
        self.set_pin_state(Settings.instance.pins.output.exhaust, GPIO.LOW)

    @QtCore.Slot()
    def chiller_changed(self):
        if sys.platform == 'linux':
            self.set_pin_state(Settings.instance.pins.output.chiller, self.__view_model.chiller)

    @QtCore.Slot()
    def exhaust_changed(self):
        if sys.platform == 'linux':
            self.set_pin_state(Settings.instance.pins.output.exhaust, self.__view_model.exhaust)
