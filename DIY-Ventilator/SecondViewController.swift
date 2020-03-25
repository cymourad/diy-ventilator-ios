//
//  SecondViewController.swift
//  DIY-Ventilator
//
//  Created by Nicolas Mourad on 2020-03-22.
//  Copyright © 2020 Christian Mourad. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class SecondViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var selectedVideo = "My Movie" //default tutorial to play
    
    // SETTING PICKER UP
    
    @IBOutlet weak var tutorialPicker: UIPickerView!
    
    // Picker options
    let tutorials = ["Welcome to DIY-Ventilator", "COVID-19 and ventilators", "Types of ventilators", "Monitoring the patient", "Assemble the ventilator", "Run ventilator on battery"]
    let videoTutorials = ["Welcome to DIY-Ventilator", "Assemble the ventilator", "Run ventilator on battery"]
    
    // we only have one field to pick
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // the items to be displayed in the picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tutorials[row]
    }
    
    // the number of items in the picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tutorials.count
    }
    
    //
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedVideo = tutorials[row]
    }
    
    // SETTING AV PLAYER UP
    
    var avPlayerViewController:AVPlayerViewController = AVPlayerViewController()
    var avPlayer:AVPlayer = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    func playVideoWithName(name: String) {
        let videoPath = Bundle.main.path(forResource: name, ofType: "mp4")
        let videoPathURL = URL(fileURLWithPath: videoPath!)
        avPlayer = AVPlayer(url: videoPathURL)
        avPlayerViewController.player = avPlayer
        
        self.present(avPlayerViewController, animated: true, completion: {
            self.avPlayerViewController.player?.play() // start playing the video as soon as player opens
        })
        
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        
        if videoTutorials.contains(selectedVideo) {
            // trigger the video to play
            playVideoWithName(name: selectedVideo)
        } else {} // TODO read the blog entry
    }
    
}

