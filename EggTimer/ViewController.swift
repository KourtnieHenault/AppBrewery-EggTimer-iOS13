//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timerBarProgressView: UIProgressView!
    
    private let eggBoilTimes = [
        "soft": 5,
        "medium": 7,
        "hard": 12
    ]
    
    private var player: AVAudioPlayer!
    private var timer = Timer()
    
    private var remainingBoilTime = 0
    private var totalBoilTime = 0
    
    @IBAction func hardnessSelectionButton(_ sender: UIButton) {
        titleLabel.text = sender.currentTitle
        timerBarProgressView.setProgress(1.00, animated: true)
        if let eggHardness = sender.currentTitle?.lowercased() {
            configureTimer(desiredHardness: eggHardness)
            startTimer()
        } else { return }
        
        
    }
    
    private func configureTimer(desiredHardness : String){
        if let eggBoilTime = eggBoilTimes[desiredHardness] {
        totalBoilTime = eggBoilTime * 60
        remainingBoilTime = eggBoilTime * 60
        } else { return }
        
    }
    
    private func startTimer() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        if(remainingBoilTime > 0) {
            print(remainingBoilTime)
            remainingBoilTime -= 1
            updatePogressBar()
        }else {
            endTimer()
        }
    }
    
    func endTimer(){
        timer.invalidate()
        playAlarm(fileName: "alarm_sound", fileExtension: "mp3")
        titleLabel.text = "Done!"
    }
    
    func updatePogressBar(){
        let progress = Float(remainingBoilTime)/Float(totalBoilTime)
        timerBarProgressView.setProgress(progress, animated: true)
    }
    
    func playAlarm(fileName: String, fileExtension: String) {
        let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension)
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()                
    }
    
}
