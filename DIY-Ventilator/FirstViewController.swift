//
//  FirstViewController.swift
//  DIY-Ventilator
//
//  Created by Nicolas Mourad on 2020-03-22.
//  Copyright © 2020 Christian Mourad. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    // SETTING UP VARIABLES
    var isConnectedToOxygen = true; //bool indicating whether oxygen tank and Y-piece are connected
    var isConnectedToHumidifier = true; //bool indicating whether humidiferis connected
    
    let modes = ["Bi-PAP", "C-PAP", "Assist"] // the different modes of operation
    var mode = "Bi-PAP" // string indicating the desired mode of operation
    
    var IPAP = 16 // integer indicating the value of the IPAP
    var EPAP = 8 // integer indicating the value of the EPAP
    var CPAP =  10 // integer indicating the value of the CPAP
    
    var patientAge = 50 // age in years
    var patientHeight = 175 // height in cm
    var patientWeight = 75 // weight in kgs
    var isMale = true // bool indicating patient's sex
    
    var testVar = "Bi-PAP" // variable used for testing
    
    // LISTENING TO CONTROLS
    
    // match humidifer connection bool to switch
    @IBAction func humidiferSwitch(_ sender: UISwitch) {
        isConnectedToHumidifier = sender.isOn
    }
    
    // match oxygen connection bool to switch
    @IBAction func oxygenSwitch(_ sender: UISwitch) {
        isConnectedToOxygen = sender.isOn
    }
    
    // Mode
    @IBAction func modeSegment(_ sender: UISegmentedControl) {
        mode = modes[sender.selectedSegmentIndex]
    }
    
    
    // IPAP
    @IBOutlet weak var IPAPlabel: UILabel!
    @IBAction func IPAPstepper(_ sender: UIStepper) {
        IPAP = Int(sender.value) // store new value in IPAP (to be send over bluetooth)
        IPAPlabel.text = String(IPAP) // display new value to user in app
    }
    
    // EPAP
    @IBOutlet weak var EPAPlabel: UILabel!
    @IBAction func EPAPstepper(_ sender: UIStepper) {
        EPAP = Int(sender.value) // store new value in EPAP (to be send over bluetooth)
        EPAPlabel.text = String(EPAP) // display new value to user in app
    }
    
    // CPAP
    @IBOutlet weak var CPAPlabel: UILabel!
    @IBAction func CPAPstepper(_ sender: UIStepper) {
        CPAP = Int(sender.value) // store new value in CPAP (to be send over bluetooth)
        CPAPlabel.text = String(CPAP) // display new value to user in app
    }
    
    // Age
    @IBOutlet weak var ageLabel: UILabel!
    @IBAction func ageStepper(_ sender: UIStepper) {
        patientAge = Int(sender.value) // store new value in patientAge (to be send over bluetooth)
        ageLabel.text = String(patientAge) // display new value to user in app
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
    
    // Sex
    @IBAction func sexSegment(_ sender: UISegmentedControl) {
        isMale = (sender.selectedSegmentIndex == 0)
    }
    
    // Send settings to the ventialtor
    @IBAction func sendSettingsToVentilatorButtonTapped(_ sender: UIButton) {
        switch mode {
        case modes[0]: // Bi-PAP
            // do claculations needed for Bi-PAP
            // TODO
            testVar = "Bi-PAP"
        case modes[1]: //C-PAP
            // do calculations needed for C-PAP
            // TODO
            testVar = "C-PAP"
        default:
            // deafault to assist
            // TODO
            testVar = "Assist"
        }
        
        // send required data over Bluetooth
        // TODO
        
        // update label upon success
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .none
        let timeString = formatter.string(from: currentDateTime)
        testLabel.text =  "Settings sent successfully at " + timeString
    }
    
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

