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
    
    let eggTimes = ["Soft":5.0, "Medium":7.0, "Hard":12.0]
    var objPlayer: AVAudioPlayer?
    var animator = UIViewPropertyAnimator()
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var progress: UIProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()
        progress.isHidden = true
    }
    
    func playAudioFile() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)

            // For iOS 11
            objPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            // For iOS versions < 11
            objPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let aPlayer = objPlayer else { return }
            aPlayer.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func touched(_ sender: UIButton) {
        progress.isHidden = true
        animator = UIViewPropertyAnimator()
        topLabel.text = "How do you like your eggs?"
        progress.setProgress(0.0, animated: true)
        progress.isHidden = false
        let animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: eggTimes[sender.currentTitle!]!, delay: 0, options: [], animations: {() -> Void in self.progress.setProgress(1.0, animated: true)}, completion: {(UIViewAnimatingPosition) -> Void in self.topLabel.text = "Done"
            self.playAudioFile()
        })
        
    }
    


}
