EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:cat24c32wi
LIBS:relays
LIBS:74xgxx
LIBS:ac-dc
LIBS:actel
LIBS:Altera
LIBS:analog_devices
LIBS:brooktre
LIBS:cmos_ieee
LIBS:dc-dc
LIBS:diode
LIBS:elec-unifil
LIBS:ESD_Protection
LIBS:ftdi
LIBS:gennum
LIBS:graphic
LIBS:hc11
LIBS:ir
LIBS:Lattice
LIBS:logo
LIBS:maxim
LIBS:microchip_dspic33dsc
LIBS:microchip_pic10mcu
LIBS:microchip_pic12mcu
LIBS:microchip_pic16mcu
LIBS:microchip_pic18mcu
LIBS:microchip_pic32mcu
LIBS:motor_drivers
LIBS:msp430
LIBS:nordicsemi
LIBS:nxp_armmcu
LIBS:onsemi
LIBS:Oscillators
LIBS:Power_Management
LIBS:powerint
LIBS:pspice
LIBS:references
LIBS:rfcom
LIBS:sensors
LIBS:silabs
LIBS:stm8
LIBS:stm32
LIBS:supertex
LIBS:switches
LIBS:transf
LIBS:ttl_ieee
LIBS:video
LIBS:Xicor
LIBS:Zilog
LIBS:Transistors
LIBS:RPi_Hat-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "LaserPi Hat"
Date "2016-04-04"
Rev "1.0"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L RPi_GPIO J1
U 1 1 570413A8
P 7150 2800
F 0 "J1" H 7900 3050 60  0000 C CNN
F 1 "RPi_GPIO" H 7900 2950 60  0000 C CNN
F 2 "RPi_Hat:Pin_Header_Straight_2x20" H 7150 2800 60  0001 C CNN
F 3 "" H 7150 2800 60  0000 C CNN
	1    7150 2800
	1    0    0    -1  
$EndComp
Text Notes 7500 4950 0    60   Italic 0
Thru-Hole Connector
$Comp
L R R11
U 1 1 570413B0
P 6150 2850
F 0 "R11" V 6230 2850 50  0000 C CNN
F 1 "4k7" V 6150 2850 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 6080 2850 50  0001 C CNN
F 3 "" H 6150 2850 50  0000 C CNN
	1    6150 2850
	0    -1   -1   0   
$EndComp
$Comp
L CONN_01X03 P3
U 1 1 570413B7
P 5750 2950
F 0 "P3" H 5750 3150 50  0000 C CNN
F 1 "1 Wire" V 5850 2950 50  0000 C CNN
F 2 "Terminal_Blocks:TerminalBlock_Pheonix_MPT-2.54mm_3pol" H 5750 2950 50  0001 C CNN
F 3 "" H 5750 2950 50  0000 C CNN
	1    5750 2950
	-1   0    0    1   
$EndComp
$Comp
L CONN_01X04 P5
U 1 1 570413BE
P 10050 3100
F 0 "P5" H 10050 3450 50  0000 C CNN
F 1 "Laser Controller" V 10150 3100 50  0000 C CNN
F 2 "Terminal_Blocks:TerminalBlock_Pheonix_MPT-2.54mm_4pol" H 10050 3100 50  0001 C CNN
F 3 "" H 10050 3100 50  0000 C CNN
	1    10050 3100
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X03 P1
U 1 1 570413C5
P 6400 1850
F 0 "P1" H 6400 2050 50  0000 C CNN
F 1 "Flow Meter" V 6500 1850 50  0000 C CNN
F 2 "Terminal_Blocks:TerminalBlock_Pheonix_MPT-2.54mm_3pol" H 6400 1850 50  0001 C CNN
F 3 "" H 6400 1850 50  0000 C CNN
	1    6400 1850
	0    -1   -1   0   
$EndComp
Text GLabel 5950 2700 0    60   Input ~ 0
1_WIRE
Text GLabel 6950 4600 0    60   Input ~ 0
1_WIRE
$Comp
L BSS138 Q3
U 1 1 570413CE
P 4400 4000
F 0 "Q3" H 4600 4075 50  0000 L CNN
F 1 "BSS138" H 4600 4000 50  0000 L CNN
F 2 "TO_SOT_Packages_SMD:SOT-23" H 4600 3925 50  0001 L CIN
F 3 "" H 4400 4000 50  0000 L CNN
	1    4400 4000
	-1   0    0    1   
$EndComp
$Comp
L R R5
U 1 1 570413D5
P 4550 3800
F 0 "R5" V 4630 3800 50  0000 C CNN
F 1 "10k" V 4550 3800 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 4480 3800 50  0001 C CNN
F 3 "" H 4550 3800 50  0000 C CNN
	1    4550 3800
	0    1    1    0   
$EndComp
Text GLabel 6950 4500 0    60   Input ~ 0
FLOW_METER
$Comp
L R R6
U 1 1 570413DD
P 4550 4200
F 0 "R6" V 4630 4200 50  0000 C CNN
F 1 "10k" V 4550 4200 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 4480 4200 50  0001 C CNN
F 3 "" H 4550 4200 50  0000 C CNN
	1    4550 4200
	0    1    1    0   
$EndComp
Text GLabel 9850 3050 0    60   Input ~ 0
LC2
Text GLabel 9850 3150 0    60   Input ~ 0
LC4
Text GLabel 4300 3650 0    60   Input ~ 0
FLOW_METER
$Comp
L BSS138 Q5
U 1 1 570413E7
P 4450 6700
F 0 "Q5" H 4650 6775 50  0000 L CNN
F 1 "BSS138" H 4650 6700 50  0000 L CNN
F 2 "TO_SOT_Packages_SMD:SOT-23" H 4650 6625 50  0001 L CIN
F 3 "" H 4450 6700 50  0000 L CNN
	1    4450 6700
	-1   0    0    1   
$EndComp
$Comp
L BSS138 Q4
U 1 1 570413EE
P 4400 5450
F 0 "Q4" H 4600 5525 50  0000 L CNN
F 1 "BSS138" H 4600 5450 50  0000 L CNN
F 2 "TO_SOT_Packages_SMD:SOT-23" H 4600 5375 50  0001 L CIN
F 3 "" H 4400 5450 50  0000 L CNN
	1    4400 5450
	-1   0    0    1   
$EndComp
$Comp
L R R8
U 1 1 570413F5
P 4550 5650
F 0 "R8" V 4630 5650 50  0000 C CNN
F 1 "10k" V 4550 5650 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 4480 5650 50  0001 C CNN
F 3 "" H 4550 5650 50  0000 C CNN
	1    4550 5650
	0    1    1    0   
$EndComp
$Comp
L R R7
U 1 1 570413FC
P 4550 5250
F 0 "R7" V 4630 5250 50  0000 C CNN
F 1 "10k" V 4550 5250 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 4480 5250 50  0001 C CNN
F 3 "" H 4550 5250 50  0000 C CNN
	1    4550 5250
	0    -1   -1   0   
$EndComp
Text GLabel 6950 3500 0    60   Input ~ 0
LC_WORKING
Text GLabel 8850 3600 2    60   Input ~ 0
LC_AIR
Text GLabel 4300 5100 0    60   Input ~ 0
LC_WORKING
Text GLabel 4300 5650 3    60   Input ~ 0
LC2
$Comp
L R R9
U 1 1 57041407
P 4600 6500
F 0 "R9" V 4680 6500 50  0000 C CNN
F 1 "10k" V 4600 6500 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 4530 6500 50  0001 C CNN
F 3 "" H 4600 6500 50  0000 C CNN
	1    4600 6500
	0    -1   -1   0   
$EndComp
$Comp
L R R10
U 1 1 5704140E
P 4600 6900
F 0 "R10" V 4680 6900 50  0000 C CNN
F 1 "10k" V 4600 6900 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 4530 6900 50  0001 C CNN
F 3 "" H 4600 6900 50  0000 C CNN
	1    4600 6900
	0    -1   -1   0   
$EndComp
Text GLabel 4350 6900 3    60   Input ~ 0
LC4
Text GLabel 4350 6450 0    60   Input ~ 0
LC_AIR
$Comp
L +3.3V #PWR01
U 1 1 57041417
P 4700 3800
F 0 "#PWR01" H 4700 3650 50  0001 C CNN
F 1 "+3.3V" H 4700 3940 50  0000 C CNN
F 2 "" H 4700 3800 50  0000 C CNN
F 3 "" H 4700 3800 50  0000 C CNN
	1    4700 3800
	0    1    1    0   
$EndComp
$Comp
L +3.3V #PWR02
U 1 1 5704141D
P 4700 5250
F 0 "#PWR02" H 4700 5100 50  0001 C CNN
F 1 "+3.3V" H 4700 5390 50  0000 C CNN
F 2 "" H 4700 5250 50  0000 C CNN
F 3 "" H 4700 5250 50  0000 C CNN
	1    4700 5250
	0    1    1    0   
$EndComp
$Comp
L +3.3V #PWR03
U 1 1 57041423
P 6300 2950
F 0 "#PWR03" H 6300 2800 50  0001 C CNN
F 1 "+3.3V" H 6300 3090 50  0000 C CNN
F 2 "" H 6300 2950 50  0000 C CNN
F 3 "" H 6300 2950 50  0000 C CNN
	1    6300 2950
	0    1    1    0   
$EndComp
$Comp
L +3.3V #PWR04
U 1 1 57041429
P 6950 3600
F 0 "#PWR04" H 6950 3450 50  0001 C CNN
F 1 "+3.3V" H 6950 3740 50  0000 C CNN
F 2 "" H 6950 3600 50  0000 C CNN
F 3 "" H 6950 3600 50  0000 C CNN
	1    6950 3600
	0    -1   -1   0   
$EndComp
$Comp
L +3.3V #PWR05
U 1 1 5704142F
P 4750 6500
F 0 "#PWR05" H 4750 6350 50  0001 C CNN
F 1 "+3.3V" H 4750 6640 50  0000 C CNN
F 2 "" H 4750 6500 50  0000 C CNN
F 3 "" H 4750 6500 50  0000 C CNN
	1    4750 6500
	0    1    1    0   
$EndComp
$Comp
L +5V #PWR06
U 1 1 57041435
P 8850 2800
F 0 "#PWR06" H 8850 2650 50  0001 C CNN
F 1 "+5V" H 8850 2940 50  0000 C CNN
F 2 "" H 8850 2800 50  0000 C CNN
F 3 "" H 8850 2800 50  0000 C CNN
	1    8850 2800
	0    1    1    0   
$EndComp
$Comp
L +24V #PWR07
U 1 1 5704143B
P 4800 6900
F 0 "#PWR07" H 4800 6750 50  0001 C CNN
F 1 "+24V" H 4800 7040 50  0000 C CNN
F 2 "" H 4800 6900 50  0000 C CNN
F 3 "" H 4800 6900 50  0000 C CNN
	1    4800 6900
	0    1    1    0   
$EndComp
$Comp
L +24V #PWR08
U 1 1 57041441
P 4700 5650
F 0 "#PWR08" H 4700 5500 50  0001 C CNN
F 1 "+24V" H 4700 5790 50  0000 C CNN
F 2 "" H 4700 5650 50  0000 C CNN
F 3 "" H 4700 5650 50  0000 C CNN
	1    4700 5650
	0    1    1    0   
$EndComp
$Comp
L +24V #PWR09
U 1 1 57041447
P 9850 3250
F 0 "#PWR09" H 9850 3100 50  0001 C CNN
F 1 "+24V" H 9850 3390 50  0000 C CNN
F 2 "" H 9850 3250 50  0000 C CNN
F 3 "" H 9850 3250 50  0000 C CNN
	1    9850 3250
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR010
U 1 1 5704144D
P 9850 2950
F 0 "#PWR010" H 9850 2700 50  0001 C CNN
F 1 "GND" H 9850 2800 50  0000 C CNN
F 2 "" H 9850 2950 50  0000 C CNN
F 3 "" H 9850 2950 50  0000 C CNN
	1    9850 2950
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR011
U 1 1 57041453
P 6950 4700
F 0 "#PWR011" H 6950 4450 50  0001 C CNN
F 1 "GND" H 6950 4550 50  0000 C CNN
F 2 "" H 6950 4700 50  0000 C CNN
F 3 "" H 6950 4700 50  0000 C CNN
	1    6950 4700
	0    1    1    0   
$EndComp
$Comp
L GND #PWR012
U 1 1 57041459
P 6950 3200
F 0 "#PWR012" H 6950 2950 50  0001 C CNN
F 1 "GND" H 6950 3050 50  0000 C CNN
F 2 "" H 6950 3200 50  0000 C CNN
F 3 "" H 6950 3200 50  0000 C CNN
	1    6950 3200
	0    1    1    0   
$EndComp
$Comp
L GND #PWR013
U 1 1 5704145F
P 5950 3050
F 0 "#PWR013" H 5950 2800 50  0001 C CNN
F 1 "GND" H 5950 2900 50  0000 C CNN
F 2 "" H 5950 3050 50  0000 C CNN
F 3 "" H 5950 3050 50  0000 C CNN
	1    5950 3050
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR014
U 1 1 57041465
P 6300 2050
F 0 "#PWR014" H 6300 1800 50  0001 C CNN
F 1 "GND" H 6300 1900 50  0000 C CNN
F 2 "" H 6300 2050 50  0000 C CNN
F 3 "" H 6300 2050 50  0000 C CNN
	1    6300 2050
	0    1    1    0   
$EndComp
$Comp
L +5V #PWR015
U 1 1 5704146B
P 6500 2050
F 0 "#PWR015" H 6500 1900 50  0001 C CNN
F 1 "+5V" H 6500 2190 50  0000 C CNN
F 2 "" H 6500 2050 50  0000 C CNN
F 3 "" H 6500 2050 50  0000 C CNN
	1    6500 2050
	0    1    1    0   
$EndComp
$Comp
L +5V #PWR016
U 1 1 57041471
P 4700 4200
F 0 "#PWR016" H 4700 4050 50  0001 C CNN
F 1 "+5V" H 4700 4340 50  0000 C CNN
F 2 "" H 4700 4200 50  0000 C CNN
F 3 "" H 4700 4200 50  0000 C CNN
	1    4700 4200
	0    1    1    0   
$EndComp
$Comp
L GND #PWR017
U 1 1 57041477
P 8850 3700
F 0 "#PWR017" H 8850 3450 50  0001 C CNN
F 1 "GND" H 8850 3550 50  0000 C CNN
F 2 "" H 8850 3700 50  0000 C CNN
F 3 "" H 8850 3700 50  0000 C CNN
	1    8850 3700
	0    -1   -1   0   
$EndComp
$Comp
L CAT24C32WI U1
U 1 1 5704147D
P 8700 1650
F 0 "U1" H 8700 1950 60  0000 C CNN
F 1 "CAT24C32WI" H 8700 1400 60  0000 C CNN
F 2 "SMD_Packages:SOIC-8-N" H 8000 1500 60  0001 C CNN
F 3 "" H 8000 1500 60  0000 C CNN
	1    8700 1650
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR018
U 1 1 57041484
P 9100 1450
F 0 "#PWR018" H 9100 1200 50  0001 C CNN
F 1 "GND" H 9100 1300 50  0000 C CNN
F 2 "" H 9100 1450 50  0000 C CNN
F 3 "" H 9100 1450 50  0000 C CNN
	1    9100 1450
	0    -1   -1   0   
$EndComp
$Comp
L R R12
U 1 1 5704148A
P 8150 1450
F 0 "R12" V 8230 1450 50  0000 C CNN
F 1 "0" V 8150 1450 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 8080 1450 50  0001 C CNN
F 3 "" H 8150 1450 50  0000 C CNN
	1    8150 1450
	0    1    1    0   
$EndComp
$Comp
L R R13
U 1 1 57041491
P 8150 1550
F 0 "R13" V 8230 1550 50  0000 C CNN
F 1 "0" V 8150 1550 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 8080 1550 50  0001 C CNN
F 3 "" H 8150 1550 50  0000 C CNN
	1    8150 1550
	0    1    1    0   
$EndComp
$Comp
L R R14
U 1 1 57041498
P 8150 1650
F 0 "R14" V 8230 1650 50  0000 C CNN
F 1 "0" V 8150 1650 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 8080 1650 50  0001 C CNN
F 3 "" H 8150 1650 50  0000 C CNN
	1    8150 1650
	0    1    1    0   
$EndComp
$Comp
L +3.3V #PWR019
U 1 1 5704149F
P 7900 1450
F 0 "#PWR019" H 7900 1300 50  0001 C CNN
F 1 "+3.3V" H 7900 1590 50  0000 C CNN
F 2 "" H 7900 1450 50  0000 C CNN
F 3 "" H 7900 1450 50  0000 C CNN
	1    7900 1450
	0    -1   -1   0   
$EndComp
$Comp
L +3.3V #PWR020
U 1 1 570414A5
P 9200 1550
F 0 "#PWR020" H 9200 1400 50  0001 C CNN
F 1 "+3.3V" H 9200 1690 50  0000 C CNN
F 2 "" H 9200 1550 50  0000 C CNN
F 3 "" H 9200 1550 50  0000 C CNN
	1    9200 1550
	0    1    1    0   
$EndComp
Text GLabel 8850 4100 2    60   Input ~ 0
ID_SC
Text GLabel 6950 4100 0    60   Input ~ 0
ID_SD
Text GLabel 9100 1700 2    60   Input ~ 0
ID_SD
Text GLabel 9100 1800 2    60   Input ~ 0
ID_SC
Text GLabel 4050 2350 0    60   Input ~ 0
LIGHTS
Text GLabel 6950 3400 0    60   Input ~ 0
LIGHTS
Text GLabel 6950 3300 0    60   Input ~ 0
MC_EXTRA_1
$Comp
L CONN_01X04 P2
U 1 1 570414B2
P 5600 1800
F 0 "P2" H 5600 2050 50  0000 C CNN
F 1 "Extra" V 5700 1800 50  0000 C CNN
F 2 "Terminal_Blocks:TerminalBlock_Pheonix_MPT-2.54mm_4pol" V 5800 1750 50  0001 C CNN
F 3 "" H 5600 1800 50  0000 C CNN
	1    5600 1800
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR021
U 1 1 570414B9
P 5450 2000
F 0 "#PWR021" H 5450 1750 50  0001 C CNN
F 1 "GND" H 5450 1850 50  0000 C CNN
F 2 "" H 5450 2000 50  0000 C CNN
F 3 "" H 5450 2000 50  0000 C CNN
	1    5450 2000
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR022
U 1 1 570414BF
P 5750 2000
F 0 "#PWR022" H 5750 1850 50  0001 C CNN
F 1 "+5V" H 5750 2140 50  0000 C CNN
F 2 "" H 5750 2000 50  0000 C CNN
F 3 "" H 5750 2000 50  0000 C CNN
	1    5750 2000
	-1   0    0    1   
$EndComp
Text GLabel 5650 2000 3    60   Input ~ 0
EP1
Text GLabel 5550 2000 3    60   Input ~ 0
LP1
$Comp
L BSS138 Q1
U 1 1 570414C7
P 4100 1500
F 0 "Q1" H 4300 1575 50  0000 L CNN
F 1 "BSS138" H 4300 1500 50  0000 L CNN
F 2 "TO_SOT_Packages_SMD:SOT-23" H 4300 1425 50  0001 L CIN
F 3 "" H 4100 1500 50  0000 L CNN
	1    4100 1500
	-1   0    0    1   
$EndComp
$Comp
L R R2
U 1 1 570414CE
P 4250 1700
F 0 "R2" V 4330 1700 50  0000 C CNN
F 1 "10k" V 4250 1700 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 4180 1700 50  0001 C CNN
F 3 "" H 4250 1700 50  0000 C CNN
	1    4250 1700
	0    1    1    0   
$EndComp
$Comp
L R R1
U 1 1 570414D5
P 4250 1300
F 0 "R1" V 4330 1300 50  0000 C CNN
F 1 "10k" V 4250 1300 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 4180 1300 50  0001 C CNN
F 3 "" H 4250 1300 50  0000 C CNN
	1    4250 1300
	0    -1   -1   0   
$EndComp
Text GLabel 4000 1150 0    60   Input ~ 0
MC_EXTRA_1
Text GLabel 4000 1700 3    60   Input ~ 0
EP1
$Comp
L +3.3V #PWR023
U 1 1 570414DE
P 4400 1300
F 0 "#PWR023" H 4400 1150 50  0001 C CNN
F 1 "+3.3V" H 4400 1440 50  0000 C CNN
F 2 "" H 4400 1300 50  0000 C CNN
F 3 "" H 4400 1300 50  0000 C CNN
	1    4400 1300
	0    1    1    0   
$EndComp
$Comp
L +5V #PWR024
U 1 1 570414E4
P 4400 1700
F 0 "#PWR024" H 4400 1550 50  0001 C CNN
F 1 "+5V" H 4400 1840 50  0000 C CNN
F 2 "" H 4400 1700 50  0000 C CNN
F 3 "" H 4400 1700 50  0000 C CNN
	1    4400 1700
	0    1    1    0   
$EndComp
NoConn ~ 8850 4700
NoConn ~ 8850 4600
NoConn ~ 8850 4500
NoConn ~ 8850 4300
NoConn ~ 8850 4000
NoConn ~ 8850 3900
NoConn ~ 8850 3400
NoConn ~ 8850 3300
NoConn ~ 8850 3200
NoConn ~ 8850 3100
NoConn ~ 6950 2900
NoConn ~ 6950 3000
NoConn ~ 6950 3700
NoConn ~ 6950 3800
NoConn ~ 6950 3900
NoConn ~ 8300 1750
NoConn ~ 6950 4000
NoConn ~ 8850 4200
NoConn ~ 8850 4400
NoConn ~ 8850 3000
$Comp
L CONN_01X02 P4
U 1 1 57041501
P 7300 2000
F 0 "P4" H 7300 2150 50  0000 C CNN
F 1 "Display" V 7400 2000 50  0000 C CNN
F 2 "Terminal_Blocks:TerminalBlock_Pheonix_MPT-2.54mm_2pol" H 7300 2000 50  0001 C CNN
F 3 "" H 7300 2000 50  0000 C CNN
	1    7300 2000
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR025
U 1 1 57041508
P 7250 2200
F 0 "#PWR025" H 7250 1950 50  0001 C CNN
F 1 "GND" H 7250 2050 50  0000 C CNN
F 2 "" H 7250 2200 50  0000 C CNN
F 3 "" H 7250 2200 50  0000 C CNN
	1    7250 2200
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR026
U 1 1 5704150E
P 7350 2200
F 0 "#PWR026" H 7350 2050 50  0001 C CNN
F 1 "+5V" H 7350 2340 50  0000 C CNN
F 2 "" H 7350 2200 50  0000 C CNN
F 3 "" H 7350 2200 50  0000 C CNN
	1    7350 2200
	0    1    1    0   
$EndComp
NoConn ~ 8850 3800
NoConn ~ 8850 3500
NoConn ~ 6950 2800
NoConn ~ 6950 3100
Wire Wire Line
	4300 3800 4400 3800
Wire Wire Line
	4600 3950 4700 3950
Wire Wire Line
	4700 3950 4700 3800
Wire Wire Line
	4300 4200 4400 4200
Wire Wire Line
	4300 3650 4300 3800
Wire Wire Line
	6000 2850 5950 2850
Wire Wire Line
	4300 5650 4400 5650
Wire Wire Line
	4300 5250 4400 5250
Wire Wire Line
	4600 5400 4700 5400
Wire Wire Line
	4700 5400 4700 5250
Wire Wire Line
	4350 6900 4450 6900
Wire Wire Line
	4350 6500 4450 6500
Wire Wire Line
	4650 6650 4750 6650
Wire Wire Line
	4750 6650 4750 6500
Wire Wire Line
	4300 5250 4300 5100
Wire Wire Line
	4350 6500 4350 6450
Wire Wire Line
	5950 2850 5950 2700
Wire Wire Line
	6300 2950 6300 2850
Wire Wire Line
	8850 2900 8850 2800
Wire Wire Line
	4750 6900 4800 6900
Wire Wire Line
	8000 1450 8000 1650
Connection ~ 8000 1550
Wire Wire Line
	8000 1450 7900 1450
Wire Wire Line
	9100 1550 9200 1550
Wire Wire Line
	4000 1700 4100 1700
Wire Wire Line
	4000 1300 4100 1300
Wire Wire Line
	4300 1450 4400 1450
Wire Wire Line
	4400 1450 4400 1300
Wire Wire Line
	4000 1300 4000 1150
Wire Wire Line
	5950 2950 6300 2950
$Comp
L BSS138 Q2
U 1 1 57041536
P 4150 2700
F 0 "Q2" H 4350 2775 50  0000 L CNN
F 1 "BSS138" H 4350 2700 50  0000 L CNN
F 2 "TO_SOT_Packages_SMD:SOT-23" H 4350 2625 50  0001 L CIN
F 3 "" H 4150 2700 50  0000 L CNN
	1    4150 2700
	-1   0    0    1   
$EndComp
$Comp
L R R4
U 1 1 5704153D
P 4300 2900
F 0 "R4" V 4380 2900 50  0000 C CNN
F 1 "10k" V 4300 2900 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 4230 2900 50  0001 C CNN
F 3 "" H 4300 2900 50  0000 C CNN
	1    4300 2900
	0    1    1    0   
$EndComp
$Comp
L R R3
U 1 1 57041544
P 4300 2500
F 0 "R3" V 4380 2500 50  0000 C CNN
F 1 "10k" V 4300 2500 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 4230 2500 50  0001 C CNN
F 3 "" H 4300 2500 50  0000 C CNN
	1    4300 2500
	0    -1   -1   0   
$EndComp
Text GLabel 4050 2900 3    60   Input ~ 0
LP1
$Comp
L +3.3V #PWR027
U 1 1 5704154C
P 4450 2500
F 0 "#PWR027" H 4450 2350 50  0001 C CNN
F 1 "+3.3V" H 4450 2640 50  0000 C CNN
F 2 "" H 4450 2500 50  0000 C CNN
F 3 "" H 4450 2500 50  0000 C CNN
	1    4450 2500
	0    1    1    0   
$EndComp
$Comp
L +5V #PWR028
U 1 1 57041552
P 4450 2900
F 0 "#PWR028" H 4450 2750 50  0001 C CNN
F 1 "+5V" H 4450 3040 50  0000 C CNN
F 2 "" H 4450 2900 50  0000 C CNN
F 3 "" H 4450 2900 50  0000 C CNN
	1    4450 2900
	0    1    1    0   
$EndComp
Wire Wire Line
	4050 2900 4150 2900
Wire Wire Line
	4050 2500 4150 2500
Wire Wire Line
	4350 2650 4450 2650
Wire Wire Line
	4450 2650 4450 2500
Wire Wire Line
	4050 2500 4050 2350
Text GLabel 6400 2050 3    60   Input ~ 0
FLOW_INPUT
Text GLabel 4300 4200 3    60   Input ~ 0
FLOW_INPUT
Text GLabel 6950 4400 0    60   Input ~ 0
OUT_AIR
Text GLabel 6950 4300 0    60   Input ~ 0
OUT_CHILLER
Text GLabel 6950 4200 0    60   Input ~ 0
OUT_EXHAUST
$Comp
L PZT2222A Q7
U 1 1 5705A6E9
P 2200 5600
F 0 "Q7" H 2400 5675 50  0000 L CNN
F 1 "PZT2222A" H 2400 5600 50  0000 L CNN
F 2 "TO_SOT_Packages_SMD:SOT-23" H 2400 5525 50  0001 L CIN
F 3 "" H 2200 5600 50  0000 L CNN
	1    2200 5600
	1    0    0    -1  
$EndComp
$Comp
L R R19
U 1 1 5705C631
P 2000 5450
F 0 "R19" V 2080 5450 50  0000 C CNN
F 1 "4K7" V 2000 5450 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 1930 5450 50  0001 C CNN
F 3 "" H 2000 5450 50  0000 C CNN
	1    2000 5450
	1    0    0    -1  
$EndComp
$Comp
L R R16
U 1 1 5705D1DF
P 1850 5600
F 0 "R16" V 1930 5600 50  0000 C CNN
F 1 "4K7" V 1850 5600 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 1780 5600 50  0001 C CNN
F 3 "" H 1850 5600 50  0000 C CNN
	1    1850 5600
	0    1    1    0   
$EndComp
$Comp
L GND #PWR029
U 1 1 5705D7B5
P 2300 5800
F 0 "#PWR029" H 2300 5550 50  0001 C CNN
F 1 "GND" H 2300 5650 50  0000 C CNN
F 2 "" H 2300 5800 50  0000 C CNN
F 3 "" H 2300 5800 50  0000 C CNN
	1    2300 5800
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR030
U 1 1 5705DC40
P 2000 5300
F 0 "#PWR030" H 2000 5150 50  0001 C CNN
F 1 "+5V" H 2000 5440 50  0000 C CNN
F 2 "" H 2000 5300 50  0000 C CNN
F 3 "" H 2000 5300 50  0000 C CNN
	1    2000 5300
	1    0    0    -1  
$EndComp
Text GLabel 2300 5400 2    60   Input ~ 0
HEADER_CHILLER
$Comp
L PZT2222A Q6
U 1 1 5705EC78
P 2200 4650
F 0 "Q6" H 2400 4725 50  0000 L CNN
F 1 "PZT2222A" H 2400 4650 50  0000 L CNN
F 2 "TO_SOT_Packages_SMD:SOT-23" H 2400 4575 50  0001 L CIN
F 3 "" H 2200 4650 50  0000 L CNN
	1    2200 4650
	1    0    0    -1  
$EndComp
$Comp
L R R18
U 1 1 5705EC7E
P 2000 4500
F 0 "R18" V 2080 4500 50  0000 C CNN
F 1 "4K7" V 2000 4500 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 1930 4500 50  0001 C CNN
F 3 "" H 2000 4500 50  0000 C CNN
	1    2000 4500
	1    0    0    -1  
$EndComp
$Comp
L R R15
U 1 1 5705EC84
P 1850 4650
F 0 "R15" V 1930 4650 50  0000 C CNN
F 1 "4K7" V 1850 4650 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 1780 4650 50  0001 C CNN
F 3 "" H 1850 4650 50  0000 C CNN
	1    1850 4650
	0    1    1    0   
$EndComp
$Comp
L GND #PWR031
U 1 1 5705EC8A
P 2300 4850
F 0 "#PWR031" H 2300 4600 50  0001 C CNN
F 1 "GND" H 2300 4700 50  0000 C CNN
F 2 "" H 2300 4850 50  0000 C CNN
F 3 "" H 2300 4850 50  0000 C CNN
	1    2300 4850
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR032
U 1 1 5705EC90
P 2000 4350
F 0 "#PWR032" H 2000 4200 50  0001 C CNN
F 1 "+5V" H 2000 4490 50  0000 C CNN
F 2 "" H 2000 4350 50  0000 C CNN
F 3 "" H 2000 4350 50  0000 C CNN
	1    2000 4350
	1    0    0    -1  
$EndComp
Text GLabel 2300 4450 2    60   Input ~ 0
HEADER_EXHAUST
$Comp
L PZT2222A Q8
U 1 1 5705F33E
P 2200 6550
F 0 "Q8" H 2400 6625 50  0000 L CNN
F 1 "PZT2222A" H 2400 6550 50  0000 L CNN
F 2 "TO_SOT_Packages_SMD:SOT-23" H 2400 6475 50  0001 L CIN
F 3 "" H 2200 6550 50  0000 L CNN
	1    2200 6550
	1    0    0    -1  
$EndComp
$Comp
L R R20
U 1 1 5705F344
P 2000 6400
F 0 "R20" V 2080 6400 50  0000 C CNN
F 1 "4K7" V 2000 6400 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 1930 6400 50  0001 C CNN
F 3 "" H 2000 6400 50  0000 C CNN
	1    2000 6400
	1    0    0    -1  
$EndComp
$Comp
L R R17
U 1 1 5705F34A
P 1850 6550
F 0 "R17" V 1930 6550 50  0000 C CNN
F 1 "4K7" V 1850 6550 50  0000 C CNN
F 2 "Resistors_SMD:R_1206_HandSoldering" V 1780 6550 50  0001 C CNN
F 3 "" H 1850 6550 50  0000 C CNN
	1    1850 6550
	0    1    1    0   
$EndComp
$Comp
L GND #PWR033
U 1 1 5705F350
P 2300 6750
F 0 "#PWR033" H 2300 6500 50  0001 C CNN
F 1 "GND" H 2300 6600 50  0000 C CNN
F 2 "" H 2300 6750 50  0000 C CNN
F 3 "" H 2300 6750 50  0000 C CNN
	1    2300 6750
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR034
U 1 1 5705F356
P 2000 6250
F 0 "#PWR034" H 2000 6100 50  0001 C CNN
F 1 "+5V" H 2000 6390 50  0000 C CNN
F 2 "" H 2000 6250 50  0000 C CNN
F 3 "" H 2000 6250 50  0000 C CNN
	1    2000 6250
	1    0    0    -1  
$EndComp
Text GLabel 2300 6350 2    60   Input ~ 0
HEADER_AIR
Text GLabel 1700 6550 0    60   Input ~ 0
OUT_AIR
Text GLabel 1700 4650 0    60   Input ~ 0
OUT_EXHAUST
Text GLabel 1700 5600 0    60   Input ~ 0
OUT_CHILLER
$Comp
L CONN_01X04 P6
U 1 1 5706120C
P 2550 3850
F 0 "P6" H 2550 4200 50  0000 C CNN
F 1 "Laser Controller" V 2650 3850 50  0000 C CNN
F 2 "Terminal_Blocks:TerminalBlock_Pheonix_MPT-2.54mm_4pol" H 2550 3850 50  0001 C CNN
F 3 "" H 2550 3850 50  0000 C CNN
	1    2550 3850
	0    1    1    0   
$EndComp
$Comp
L GND #PWR035
U 1 1 5706186A
P 2700 3650
F 0 "#PWR035" H 2700 3400 50  0001 C CNN
F 1 "GND" H 2700 3500 50  0000 C CNN
F 2 "" H 2700 3650 50  0000 C CNN
F 3 "" H 2700 3650 50  0000 C CNN
	1    2700 3650
	0    -1   -1   0   
$EndComp
Text GLabel 2600 3650 1    60   Input ~ 0
HEADER_AIR
Text GLabel 2400 3650 1    60   Input ~ 0
HEADER_EXHAUST
Text GLabel 2500 3650 1    60   Input ~ 0
HEADER_CHILLER
$EndSCHEMATC
