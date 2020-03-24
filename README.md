# diy-ventilator-ios
IOS app to control the DIY-Ventilator
The physical ventilator can be found [here](https://github.com/cymourad/diy-ventilator).

## Control
The idea is for the user (who will most likely be the operator) to enter the approriate settings for the patient through the app. The app then converts those settings into appropriate controls to be sent to the ventilator (timers, voltage control parameters, etc) through a single string.
This string would be composed of a number that contains all the information needed (going from Most Significant Digit to Least Significant Digit):
1. one digit for **mode of operation**:

| Value | Meaning |
| ----- | :-----: |
|   1   | Bi-PAP (requires respiratory rate {a timer}, IPAP {voltage}, EPAP {voltage}) |
|   2   | C-PAP (requires pressure {voltage}) |
|   3   |Assist (Then all other digits will be set to zero) |
|   4   | Test (a sequence that tests all modes and flashes an LED in different patterns to indicate success {solid} or failure {maybe different flashing patterns could indicate different component failures} ) |

2. one digit for **oxygen connection**:

| Value | Meaning |
| ----- | :-----: |
|   0   | not connected |
|   1   | connected |

3. few digits for **oxygen control**
4. few digits for **respiratory rate** timer {only in Bi-PAP mode}
5. few digits for **IPAP** voltage (or voltage of CPAP pressure)
6. few digits for **EPAP** voltage


## Bluetooth
IOS cannot interface with Bluetooth 2.0, BLE must be used.
[This tutorial](https://www.freecodecamp.org/news/ultimate-how-to-bluetooth-swift-with-hardware-in-20-minutes/) breaks the basic functions needed for and IOS app to connect to a device and send information over BLE.


Upon further thought, and with school work hitting hard, I would rather generate the control string in the app and ask the user to past this string into a 3rd party app that can connect to the HM-10 Module for now.

A great example is [this HM-10 Module](https://www.amazon.com/DSD-TECH-Bluetooth-iBeacon-Arduino/dp/B06WGZB2N4) that uses the readily-availble and free DSD TECH Bluetooth app (available to both [Android](https://play.google.com/store/apps/details?id=com.reb.dsd_ble&hl=en_CA) and [IOS](https://apps.apple.com/ca/app/dsd-tech-bluetooth/id1441528159) devices).
