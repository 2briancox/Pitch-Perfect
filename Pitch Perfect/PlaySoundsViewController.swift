//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Brian on 7/23/15.
//  Copyright (c) 2015 Melodity.com, LLC. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController, AVAudioPlayerDelegate {

    var player: AVAudioPlayer!
    var audio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fileURL = self.audio.filePath!
        player = AVAudioPlayer(contentsOfURL: fileURL, error: nil)
        player.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: audio.filePath, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func slowButtonPressed(sender: UIButton) {
        theStopper()
        playAtRate(0.6)
    }

    @IBAction func fastButtonPressed(sender: UIButton) {
        theStopper()
        playAtRate(2.0)
    }
    
    @IBAction func stopPressed(sender: UIButton) {
        theStopper()
    }
    
    func playAtRate(speed: Float) {
        theStopper()
        player.rate = speed
        player.play()
    }
    
    @IBAction func chipmunkPressed(sender: UIButton) {
        playWithVariablePitch(1000.00)
    }
    
    func playWithVariablePitch (pitch: Float) {
        
        theStopper()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func darthvaderPressed(sender: UIButton) {
        playWithVariablePitch(-700.00)
    }
    
    @IBAction func playButtonPressed(sender: UIButton) {
        playWithVariablePitch(0.00)
    }
    
    func theStopper (){
        player.stop()
        player.currentTime = 0.0
        audioEngine.stop()
        audioEngine.reset()
    }
}
