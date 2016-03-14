import logging
from threading import Timer

class PerpetualTimer(object):
    """Repeating timer"""

    __logger = logging.getLogger(__name__)
    def __init__(self, interval: float, callback):
        self.interval = interval
        self.__callback = callback
        self.__thread = Timer(self.interval, self.__handle_function)
        self.__thread.setName = "Perpetual timer"

    def __handle_function(self):
        self.__callback()
        self.__thread = Timer(self.interval,self.__handle_function)
        self.__thread.setName = "Perpetual timer2"
        self.__thread.start()

    def start(self):
        self.__thread.start()

    def cancel(self):
        self.__logger.info("Thread {0} ({1}) cancelled".format(self.__thread.name, self.__thread.ident))

        self.__thread.cancel()