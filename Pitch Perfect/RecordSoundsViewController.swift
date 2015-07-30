//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Brian on 2/11/15.
//  Copyright (c) 2015 Melodity.com, LLC. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!

    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var microphoneButton: UIButton!
    @IBOutlet weak var stopButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func recordButtonPressed(sender: UIButton) {
        recordingLabel.hidden = false
        stopButtonOutlet.hidden = false
        microphoneButton.enabled = false
        instructionsLabel.hidden = true
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String

        let recordingName = "my_audio.wav"
        
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        
        audioRecorder.delegate = self
        
        audioRecorder.meteringEnabled = true
        audioRecorder.record()
    }

    @IBAction func stopButtonPressed(sender: UIButton) {
        setNotRecording()
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    func audioRecorderDidFinishRecording (recorder: AVAudioRecorder!, successfully flag: Bool) {
        if flag {
            recordedAudio = RecordedAudio(pathArray: recorder.url, titlePassed: recorder.url.lastPathComponent!)
            self.performSegueWithIdentifier("stopButtonPressedSegue", sender: recordedAudio)
        } else {
            setNotRecording()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        setNotRecording()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stopButtonPressedSegue" {
            var playSoundsVC: PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            
            playSoundsVC.audio = data
        }
    }
    
    func setNotRecording () {
        microphoneButton.enabled = true
        recordingLabel.hidden = true
        stopButtonOutlet.hidden = true
        instructionsLabel.hidden = false
    }
}

