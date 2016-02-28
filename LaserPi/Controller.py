import sys
from threading import Thread, Timer
from PySide import QtCore
from ViewModel import MainViewModel
from Pins import Pins

if sys.platform == 'linux':
    import RPi.GPIO as GPIO

class Controller(QtCore.QObject):
    def __init__(self, viewModel: MainViewModel):
        QtCore.QObject.__init__(self)
        self.__viewModel = viewModel
        self.__gpioSetup = False
        self.__exhaustTimer = None
        self.__viewModel.chillerChanged.connect(self.chiller_changed)
        self.__viewModel.airChanged.connect(self.air_changed)

        if sys.platform == 'linux':
            self.running = 1
            self.__thread = Thread(target=self.__setupGpio)
            self.__thread.setDaemon(1)
            self.__thread.start()

    def __del__(self):
        print('Destructor called, cleaning up')
        if sys.platform == 'linux' and self.__gpioSetup:
            GPIO.cleanup()

    def __setupGpio(self):
        print("Setting up GPIO")
        GPIO.setmode(GPIO.BCM)

        GPIO.setup(Pins.exhaust, GPIO.OUT)
        GPIO.setup(Pins.chiller, GPIO.OUT)
        #GPIO.setup(Pins.airOutput, GPIO.OUT)

        GPIO.setup(Pins.working, GPIO.IN)
        GPIO.add_event_detect(Pins.working, GPIO.BOTH, callback=self.working_changed)
        print("GPIO {0} state? {1}".format(Pins.working, GPIO.input(Pins.working)))

        self.__gpioSetup = True

    def working_changed(self, channel):
        isHigh = GPIO.input(channel) == GPIO.HIGH

        if (isHigh):
            print("Laser is working")
            self.__viewModel.working = True
            self.turn_exhaust_on()
            if (self.__exhaustTimer is not None):
                self.__exhaustTimer.cancel()
                self.__exhaustTimer = None
        elif self.__viewModel.exhaust:
            print("timer is null? {0}".format(self.__exhaustTimer is None))
            if (self.__exhaustTimer is None):
                print("Starting exhaust off timer")
                self.__exhaustTimer = Timer(1, self.turn_exhaust_off)
                self.__exhaustTimer.start()
                self.__viewModel.working = False
                
    def turn_exhaust_on(self):
        print("Turning exhaust fan on")
        self.__viewModel.exhaust = True
        GPIO.output(Pins.exhaust, GPIO.HIGH)

    def turn_exhaust_off(self):
        print("Turning exhaust fan off")
        self.__viewModel.exhaust = False
        self.__exhaustTimer = None
        GPIO.output(Pins.exhaust, GPIO.LOW)

    @QtCore.Slot()
    def chiller_changed(self):
        GPIO.output(Pins.chiller, GPIO.HIGH if self.__viewModel.chiller else GPIO.LOW)
        print("Setting chiller GPIO {0} to {1}".format(Pins.chiller, "HIGH" if self.__viewModel.chiller else "LOW"))

    @QtCore.Slot()
    def air_changed(self):
        #self.__viewModel.air = not self.__viewModel.air
        print('air changed');
        #self._set_exhaustOn(not self._get_exhaustOn())
            #thread = threading.Thread(target=self._download)
            #thread.start()

