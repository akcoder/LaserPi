from PySide import QtCore

class MainViewModel(QtCore.QObject):
    """View model for the main window"""

    def __init__(self):
        QtCore.QObject.__init__(self)
        self.__air_on = False
        self.__chiller_on = False
        self.__exhaust_on = False
        self.__is_working = False
        self.__inlet_temp = -255
        self.__outlet_temp = -255
        self.__flow_rate = -255

    @QtCore.Slot()
    def exit(self):
        self.onExitClicked.emit()

    @QtCore.Slot()
    def shutdown(self):
        self.onShutdownClicked.emit()

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


    def __get_inlet_temp(self) -> float:
        return self.__inlet_temp

    def __set_inlet_temp(self, value: float):
        self.__inlet_temp = value
        self.onInletTempChanged.emit()


    def __get_flow_rate(self) -> float:
        return self.__flow_rate

    def __set_flow_rate(self, value: float):
        self.__flow_rate = value
        self.onFlowRateChanged.emit()


    def __get_outlet_temp(self) -> float:
        return self.__outlet_temp

    def __set_outlet_temp(self, value: float):
        self.__outlet_temp = value
        self.onOutletTempChanged.emit()


    onWorkingChanged = QtCore.Signal()
    onChillerChanged = QtCore.Signal()
    onExhaustChanged = QtCore.Signal()
    onAirChanged = QtCore.Signal()

    onExitClicked = QtCore.Signal()
    onShutdownClicked = QtCore.Signal()

    onInletTempChanged = QtCore.Signal()
    onOutletTempChanged = QtCore.Signal()
    onFlowRateChanged = QtCore.Signal()

    chiller = QtCore.Property(bool, __get_chiller_on, __set_chiller_on, notify=onChillerChanged)
    exhaust = QtCore.Property(bool, _get_exhaust_on, __set_exhaust_on, notify=onExhaustChanged)
    air = QtCore.Property(bool, __get_air_on, __set_air_on, notify=onAirChanged)
    working = QtCore.Property(bool, __get_is_working, __set_is_working, notify=onWorkingChanged)

    inlet_temp = QtCore.Property(float, __get_inlet_temp, __set_inlet_temp, notify=onInletTempChanged)
    outlet_temp = QtCore.Property(float, __get_outlet_temp, __set_outlet_temp, notify=onOutletTempChanged)
    flow_rate = QtCore.Property(float, __get_flow_rate, __set_flow_rate, notify=onFlowRateChanged)
