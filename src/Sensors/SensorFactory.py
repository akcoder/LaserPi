from Sensors.ISensor import ISensor
from Sensors.Temperature import Temperature
from Sensors.FlowMeter import FlowMeter

class SensorFactory(object):
    """Factory class to create sensors"""

    @staticmethod
    def factory(type, config, units) -> ISensor:
        #return eval(type + "()")
        if type == "temperature": return Temperature(config, units)
        if type == "flow": return FlowMeter(config, units)
        assert 0, "Unknown sensor type '%s'" % type