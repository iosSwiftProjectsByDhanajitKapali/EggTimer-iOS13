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
    
    var player: AVAudioPlayer?
    
    //dictionary storing the time to get desired egg
    let eggTimes = ["Soft":3 , "Medium":4 , "Hard":7]
    var timer  = Timer()    //initializing with timer type value
    var totalTime = 0       //initializing with 0
    var secondspassed = 0   //initializing with 0
    
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var titleTop: UILabel!
    
    @IBAction func eggHardness(_ sender: UIButton) {
            
        
        progressBar.progress = 0.0  //reset the progress bar
        secondspassed = 0           //reset the secondspassed
        timer.invalidate()      //reset the timer
        
        let hardness = sender.currentTitle! //Soft , Medium , Hard
        
        titleTop.text = hardness        //denote the type of egg being cooked now
        
        //dectionary returns optional value
        totalTime = eggTimes[hardness]!           //getting the time to boil
        
        //timer initiated
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    //updater func() for the timer
    @objc func updateCounter() {
        if secondspassed < totalTime {
            secondspassed += 1
            progressBar.progress  = Float(secondspassed)/Float(totalTime)   //updating the progress bar
        }
        else{
            timer.invalidate()
            titleTop.text = "Done"
            playSound(soundName: "alarm_sound")     //playing sound after egg is cooked
        }
    }
    
    //function to play alarm after the egg is cooked
    func playSound(soundName : String) {
            let url = Bundle.main.url(forResource: soundName, withExtension:"mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
                    
        }
}
