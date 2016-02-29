from enum import IntEnum

class Pins(IntEnum):
    """Constant for GPIO pins used"""
    #Inputs
    working = 23
    airTrigger = 24

    #Outputs
    chiller = 6
    airOutput = 13
    exhaust = 5
