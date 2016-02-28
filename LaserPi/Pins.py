from enum import IntEnum

class Pins(IntEnum):
    """Constant for GPIO pins used"""
    led = 5
    chiller = 6
    working = 25
    airTrigger = 13
    airOutput = 99
    exhaust = 5