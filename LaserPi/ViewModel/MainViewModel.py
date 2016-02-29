import sys
from PySide import QtCore

class MainViewModel(QtCore.QObject):
    """View model for the main window"""
    def __init__(self):
        QtCore.QObject.__init__(self)
        self.__air_on = False
        self.__chiller_on = False
        self.__exhaust_on = False
        self.__is_working = False
 
    @QtCore.Slot()
    def exit(self):
        self.onExitClicked.emit()

    @QtCore.Slot()
    def shutdown(self):
        if sys.platform == "linux":
            try:
                command = "/usr/bin/sudo /sbin/shutdown --reboot now"
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


    @QtCore.Slot()
    def toggle_exhaust(self):
        self.exhaust = self.__exhaust_on = not self.exhaust
        #self.__set_exhaustOn(not self.__get_exhaustOn())
            #thread = threading.Thread(target=self._download)
            #thread.start()

    def _get_exhaust_on(self) -> bool:
        return self.__exhaust_on

    def __set_exhaust_on(self, value: bool):
        self.__exhaust_on = value
        self.onExhaustChanged.emit()
 
    def __get_is_working(self) -> bool:
        return self.__is_working

    def __set_is_working(self, value: bool):
        self.__is_working = value
        self.onWorkingChanged.emit()
 
    @QtCore.Slot()
    def toggle_chiller(self):
        self.chiller = not self.chiller

    def __get_chiller_on(self) -> bool:
        return self.__chiller_on

    def __set_chiller_on(self, value: bool):
        self.__chiller_on = value
        self.onChillerChanged.emit()
 
    @QtCore.Slot()
    def toggle_air(self):
        self.__set_air_on(not self.__get_air_on())

    def __get_air_on(self) -> bool:
        return self.__air_on

    def __set_air_on(self, value: bool):
        self.__air_on = value
        self.onAirChanged.emit()

    @QtCore.Signal
    def onWorkingChanged(self):
        pass

    @QtCore.Signal
    def onChillerChanged(self):
        pass

    @QtCore.Signal
    def onExhaustChanged(self):
        pass

    @QtCore.Signal
    def onAirChanged(self):
        pass

    @QtCore.Signal
    def onExitClicked(self):
        pass
 
    chiller = QtCore.Property(bool, __get_chiller_on, __set_chiller_on, notify=onChillerChanged)
    exhaust = QtCore.Property(bool, _get_exhaust_on, __set_exhaust_on, notify=onExhaustChanged)
    air = QtCore.Property(bool, __get_air_on, __set_air_on, notify=onAirChanged)
    working = QtCore.Property(bool, __get_is_working, __set_is_working, notify=onWorkingChanged)
