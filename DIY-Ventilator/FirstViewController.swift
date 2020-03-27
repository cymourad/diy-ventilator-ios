//
//  FirstViewController.swift
//  DIY-Ventilator
//
//  Created by Nicolas Mourad on 2020-03-22.
//  Copyright © 2020 Christian Mourad. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    // set up the paste board to copy settings string to clipboard
    let pasteboard = UIPasteboard.general
    
    // SETTING UP VARIABLES
    var isConnectedToHumidifier = true //bool indicating whether humidiferis connected
    var relativeHumidityLevel = 55 // deafult relative humidity is 55 [%]
    var temperature = 37 // deafult temperature of air is 37 [degrees Celsius]
    
    var isConnectedToOxygen = true //bool indicating whether oxygen tank and Y-piece are connected
    var FiO2 = 20 // deafult oxygen level is 20 [%]
    
    let modes = ["Bi-PAP", "C-PAP", "Assist"] // the different modes of operation
    var mode = "Bi-PAP" // string indicating the desired mode of operation
    
    var PIP = 16 // integer indicating the value of the IPAP [cmH2O]
    var PEEP = 6 // integer indicating the value of the EPAP [cmH2O]
    var RR = 16 // deafult Respiratory Rate is 16 [breaths/min]
    var I = 1 // the portion of Inspiration time in the I:E ratio
    var E = 1 // the portion of Exhalation time in the I:E ratio
    
    var patientHeight = 175 // height in cm
    var patientWeight = 75 // weight in kgs
    
    var testVar = "Bi-PAP" // variable used for testing
    
    // LISTENING TO CONTROLS
    
    // match humidifer connection bool to switch
    @IBAction func humidiferSwitch(_ sender: UISwitch) {
        isConnectedToHumidifier = sender.isOn
    }
    
    // Relative humidity
    @IBOutlet weak var relativeHumidityLabel: UILabel!
    @IBAction func humidityStepper(_ sender: UIStepper) {
        relativeHumidityLevel = Int(sender.value) // store new value in relativeHumidityLevel (to be sent over bluetooth)
        relativeHumidityLabel.text = String(relativeHumidityLevel) // dislay new value to user in app
    }
    
    // Temperature
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBAction func temperatureStepper(_ sender: UIStepper) {
        temperature = Int(sender.value) // store new value in temperature (to be sent over bluetooth)
        temperatureLabel.text = String(temperature) // dislay new value to user in app
    }
    
    // match oxygen connection bool to switch
    @IBAction func oxygenSwitch(_ sender: UISwitch) {
        isConnectedToOxygen = sender.isOn
    }
    
    // FiO2
    @IBOutlet weak var fio2Label: UILabel!

    @IBAction func fio2Stepper(_ sender: UIStepper) {
        FiO2 = Int(sender.value) // store new value in FiO2 (to be send over bluetooth)
        fio2Label.text = String(FiO2) // display new value to user in app
    }
    
    // Mode
    @IBAction func modeSegment(_ sender: UISegmentedControl) {
        mode = modes[sender.selectedSegmentIndex]
    }
    
    
    // PIP
    @IBOutlet weak var IPAPlabel: UILabel!
    @IBAction func IPAPstepper(_ sender: UIStepper) {
        PIP = Int(sender.value) // store new value in IPAP (to be send over bluetooth)
        IPAPlabel.text = String(PIP) // display new value to user in app
    }
    
    // PEEP
    @IBOutlet weak var EPAPlabel: UILabel!
    @IBAction func EPAPstepper(_ sender: UIStepper) {
        PEEP = Int(sender.value) // store new value in EPAP (to be send over bluetooth)
        EPAPlabel.text = String(PEEP) // display new value to user in app
    }
    
    // RR
    @IBOutlet weak var rrLabel: UILabel!
    @IBAction func rrStepper(_ sender: UIStepper) {
        RR = Int(sender.value) // store new value in RR (to be send over bluetooth)
        rrLabel.text = String(RR) // display new value to user in app
    }
    
    // I
    @IBOutlet weak var iLabel: UILabel!
    @IBAction func iStepper(_ sender: UIStepper) {
        I = Int(sender.value) // store new value in I (to be send over bluetooth)
        iLabel.text = String(I) // display new value to user in app
    }
    
    // E
    @IBOutlet weak var eLabel: UILabel!
    @IBAction func eStepper(_ sender: UIStepper) {
        E = Int(sender.value) // store new value in E (to be send over bluetooth)
        eLabel.text = String(E) // display new value to user in app
    }
    
    
    // Height
    @IBOutlet weak var heightLabel: UILabel!
    @IBAction func hieghtStepper(_ sender: UIStepper) {
        patientHeight = Int(sender.value) // store new value in patientHeight (to be send over bluetooth)
        heightLabel.text = String(patientHeight) // display new value to user in app
    }
    
    // Weight
    @IBOutlet weak var weightLabel: UILabel!
    @IBAction func weightStepper(_ sender: UIStepper) {
        patientWeight = Int(sender.value) // store new value in patientWeight (to be send over bluetooth)
        weightLabel.text = String(patientWeight) // display new value to user in app
    }

    
    // Send settings to the ventialtor
    @IBAction func sendSettingsToVentilatorButtonTapped(_ sender: UIButton) {
        var settingsString = ""
        
        var oxygenStatus = 0
        if isConnectedToOxygen {
            oxygenStatus = 1
        }
        
        var humidifierStatus = 0
        if isConnectedToHumidifier {
            humidifierStatus = 1
        }
        
        switch mode {
        case modes[0]: // Bi-PAP
            // Construct settings string
            settingsString = "B" + String(oxygenStatus) + String(FiO2/10) + String(humidifierStatus) + String(format: "%02d", relativeHumidityLevel) + String(format: "%02d", temperature) + String(format: "%02d", RR) + String(I) + String(E) + String(format: "%02d", PIP) + String(format: "%02d", PEEP)
        case modes[1]: //C-PAP
            // Construct settings string
            settingsString = "C" + String(oxygenStatus) + String(FiO2/10) + String(humidifierStatus) + String(format: "%02d", relativeHumidityLevel) + String(format: "%02d", temperature) + "00" + "0" + "00" + "00" + String(format: "%02d", PEEP)
        default:
            // Construct settings string
            settingsString = "A" + String(oxygenStatus) + String(FiO2/10) + String(humidifierStatus) + String(format: "%02d", relativeHumidityLevel) + String(format: "%02d", temperature) + String(format: "%02d", RR) + String(I) + String(E) + String(format: "%02d", PIP) + String(format: "%02d", PEEP)
        }
        
        // output settings string to user
        testLabel.text =  "Paste setting string to app " + settingsString
        
        // copy settings string to clipbaord
        pasteboard.string = settingsString
        
        
        // TODO send required data over Bluetooth
        // TODO update label upon success as follows
//        let currentDateTime = Date()
//        let formatter = DateFormatter()
//        formatter.timeStyle = .medium
//        formatter.dateStyle = .none
//        let timeString = formatter.string(from: currentDateTime)
//        testLabel.text =  "Settings sent successfully at " + timeString
        
    }
    
    // Test ventilator
    
    @IBAction func testVentilaorTapped(_ sender: UIButton) {
        
        var oxygenStatus = 0
        if isConnectedToOxygen {
            oxygenStatus = 1
        }
        
        var humidifierStatus = 0
        if isConnectedToHumidifier {
            humidifierStatus = 1
        }
        
        let settingsString = "T" + String(oxygenStatus) + String(FiO2/10) + String(humidifierStatus) + String(format: "%02d", relativeHumidityLevel) + String(format: "%02d", temperature) + String(format: "%02d", RR) + String(I) + String(E) + String(format: "%02d", PIP) + String(format: "%02d", PEEP)
        
        // Output settings string to user
        testLabel.text =  "Paste setting string to app " + settingsString
        
        // Copy settings string to clipboard
        pasteboard.string = settingsString
    }
    
    
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

