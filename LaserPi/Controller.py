"""The glue between the view and viewModel"""

import sys
from threading import Thread, Timer
from PySide import QtCore
from ViewModel import MainViewModel
from Pins import Pins

if sys.platform == 'linux':
    import RPi.GPIO as GPIO

class Controller(QtCore.QObject):
    """The glue between the view and viewModel"""
    def __init__(self, viewModel: MainViewModel):
        QtCore.QObject.__init__(self)
        self.__view_model = viewModel
        self.__gpio_setup = False
        self.__exhaust_timer = None
        self.__view_model.onChillerChanged.connect(self.chiller_changed)
        self.__view_model.onAirChanged.connect(self.air_trigger_changed)
        self.__view_model.onExhaustChanged.connect(self.exhaust_changed)
        self.__view_model.onExitClicked.connect(self.close)
        self.__view_model.onShutdownClicked.connect(self.shutdown)

        self._states = {
            Pins.working:GPIO.LOW,
            Pins.airTrigger:GPIO.LOW
            }

        if sys.platform == 'linux':
            self.running = 1
            self.__thread = Thread(target=self.__setup_gpio)
            self.__thread.setDaemon(1)
            self.__thread.start()

    def __del__(self):
        print('Destructor called, cleaning up')
        self.cleanup()

    def __setup_gpio(self):
        print("Setting up GPIO")
        GPIO.setmode(GPIO.BCM)

        GPIO.setup(Pins.exhaust, GPIO.OUT)
        GPIO.setup(Pins.chiller, GPIO.OUT)
        GPIO.setup(Pins.airOutput, GPIO.OUT)

        GPIO.setup(Pins.working, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
        GPIO.add_event_detect(Pins.working, GPIO.BOTH, callback=self.working_changed)

        GPIO.setup(Pins.airTrigger, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
        GPIO.add_event_detect(Pins.airTrigger, GPIO.BOTH, callback=self.air_trigger_changed)

        self.__gpio_setup = True

    def close(self):
        self.cleanup()
        QtCore.QCoreApplication.instance().quit()

    def shutdown(self):
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
        if sys.platform == 'linux' and self.__gpio_setup:
            GPIO.cleanup()

    @QtCore.Slot()
    def air_trigger_changed(self, channel=None):
        if channel is None:
            self.set_air_state(GPIO.HIGH if self.__view_model.air else GPIO.LOW)
            return
        #self.__viewModel.air = not self.__viewModel.air
        print('air changed')

    def set_air_state(self, state):
        print("Setting airOutput GPIO {0} to {1}".format(Pins.airOutput, "HIGH" if self.__view_model.air else "LOW"))
        
        GPIO.output(Pins.airOutput, state)

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

                print("Starting exhaust off timer")
                self.__exhaust_timer = Timer(1, self.turn_exhaust_off)
                self.__exhaust_timer.start()
                self.__view_model.working = False
            self._states[channel] = GPIO.LOW
                
    def turn_exhaust_on(self):
        print("Turning exhaust fan on")
        self.__view_model.exhaust = True
        GPIO.output(Pins.exhaust, GPIO.HIGH)

    def turn_exhaust_off(self):
        print("Turning exhaust fan off")
        self.__view_model.exhaust = False
        self.__exhaust_timer = None
        GPIO.output(Pins.exhaust, GPIO.LOW)

    @QtCore.Slot()
    def chiller_changed(self):
        if sys.platform == 'linux':
            GPIO.output(Pins.chiller, GPIO.HIGH if self.__view_model.chiller else GPIO.LOW)
            print("Setting chiller GPIO {0} to {1}".format(Pins.chiller, "HIGH" if self.__view_model.chiller else "LOW"))

    @QtCore.Slot()
    def exhaust_changed(self):
        if sys.platform == 'linux':
            GPIO.output(Pins.exhaust, GPIO.HIGH if self.__view_model.exhaust else GPIO.LOW)
            print("Setting exhaust GPIO {0} to {1}".format(Pins.exhaust, "HIGH" if self.__view_model.exhaust else "LOW"))

