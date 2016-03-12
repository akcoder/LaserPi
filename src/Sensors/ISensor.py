from abc import ABCMeta, abstractmethod

class ISensor(metaclass=ABCMeta):
    """Sensors"""
    @abstractmethod
    def start(self):
        pass

    @abstractmethod
    def stop(self):
        pass
