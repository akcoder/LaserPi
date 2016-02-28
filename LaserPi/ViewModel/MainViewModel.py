import sys
import threading
from PySide import QtCore
if sys.platform == "linux":
    import dbus
    #import dbus.exceptions.DBusException

class MainViewModel(QtCore.QObject):
    def __init__(self):
        QtCore.QObject.__init__(self)
        self._airOn = True
        self.__chillerOn = False
        self.__exhaustOn = False
        self._isWorking = False
 
    @QtCore.Slot()
    def shutdown(self):
        if sys.platform == "linux":
            try:
                command = "/usr/bin/sudo /sbin/shutdown --reboot now"
                import subprocess
                process = subprocess.Popen(command.split(), stdout=subprocess.PIPE)
                output = process.communicate()[0]
                print(output)
            except Exception as e:
                print("{0}".format(e))
                print("Unable to shutdown")
                sys.exit()
        elif sys.platform == 'win32':
            sys.exit()


    @QtCore.Slot()
    def toggle_exhaust(self):
        self.exhaust = not self.exhaust
        #self.__set_exhaustOn(not self.__get_exhaustOn())
            #thread = threading.Thread(target=self._download)
            #thread.start()

    def __get_exhaustOn(self) -> bool:
        return self.__exhaustOn

    def __set_exhaustOn(self, value: bool):
        self.__exhaustOn = value
        self.exhaustChanged.emit()
 
    def __get_isWorking(self) -> bool:
        return self._isWorking

    def __set_isWorking(self, value: bool):
        self._isWorking = value
        self.workingChanged.emit()
 
    @QtCore.Slot()
    def toggle_chiller(self):
        self.chiller = not self.chiller

    def __get_chillerOn(self) -> bool:
        return self.__chillerOn

    def __set_chillerOn(self, value: bool):
        self.__chillerOn = value
        self.chillerChanged.emit()
 
    @QtCore.Slot()
    def toggle_air(self):
        self.__set_airOn(not self.__get_airOn())

    def __get_airOn(self) -> bool:
        return self._airOn

    def __set_airOn(self, value: bool):
        self._airOn = value
        self.airChanged.emit()

    workingChanged = QtCore.Signal()
    chillerChanged = QtCore.Signal()
    exhaustChanged = QtCore.Signal()
    airChanged = QtCore.Signal()
 
    chiller = QtCore.Property(bool, __get_chillerOn, __set_chillerOn, notify=chillerChanged)
    exhaust = QtCore.Property(bool, __get_exhaustOn, __set_exhaustOn, notify=exhaustChanged)
    air = QtCore.Property(bool, __get_airOn, __set_airOn, notify=airChanged)
    working = QtCore.Property(bool, __get_isWorking, __set_isWorking, notify=workingChanged)