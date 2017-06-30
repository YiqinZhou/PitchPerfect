//
//  PlayViewController.swift
//  PitchPerfect
//
//  Created by ZhouYiqin on 6/28/17.
//  Copyright © 2017 Yiqin Zhou. All rights reserved.
//

import UIKit
import AVFoundation

class PlayViewController: UIViewController,AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    var soundFile: URL?
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    var audioPlayer: AVAudioPlayer!
    var audioPlayerNode: AVAudioPlayerNode!
    
 
    




    struct Alerts {
        static let DismissAlert = "Dismiss"
        static let RecordingDisabledTitle = "Recording Disabled"
        static let RecordingDisabledMessage = "You've disabled this app from recording your microphone. Check Settings."
        static let RecordingFailedTitle = "Recording Failed"
        static let RecordingFailedMessage = "Something went wrong with your recording."
        static let AudioRecorderError = "Audio Recorder Error"
        static let AudioSessionError = "Audio Session Error"
        static let AudioRecordingError = "Audio Recording Error"
        static let AudioFileError = "Audio File Error"
        static let AudioEngineError = "Audio Engine Error"
    }
    func showAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Alerts.DismissAlert, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }



    @IBOutlet weak var squirrel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        
        audioEngine=AVAudioEngine()
        do{
            audioFile = try AVAudioFile(forReading: soundFile as URL!)
        } catch {
            showAlert(Alerts.AudioFileError, message: String(describing: error))
        }
        
        
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
      
        let audioPlayerNode=AVAudioPlayerNode()
        audioEngine.attach(audioPlayerNode)
        let changePitchNode=AVAudioUnitTimePitch()
        changePitchNode.pitch=pitch
        audioEngine.attach(changePitchNode)
        audioEngine.connect(audioPlayerNode, to:changePitchNode, format:audioFile.processingFormat)
        audioEngine.connect(changePitchNode, to:audioEngine.outputNode, format:audioFile.processingFormat)
        audioPlayerNode.stop()
        audioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
        do {
            try audioEngine.start()
        } catch {
            showAlert(Alerts.AudioEngineError, message: String(describing: error))
            return
        }
        
        // play the recording!
        audioPlayerNode.play()
    }
    
    func playAudioWithVariableRate(rate: Float){
        if let audioPlayerNode = audioPlayerNode {
            audioPlayerNode.stop()
        }
        
        if let audioEngine = audioEngine {
            audioEngine.stop()
            audioEngine.reset()
        }
        
        let audioPlayerNode=AVAudioPlayerNode()
        audioEngine.attach(audioPlayerNode)
        let changePitchNode=AVAudioUnitTimePitch()
        changePitchNode.rate=rate
        audioEngine.attach(changePitchNode)
        audioEngine.connect(audioPlayerNode, to:changePitchNode, format:audioFile.processingFormat)
        audioEngine.connect(changePitchNode, to:audioEngine.outputNode, format:audioFile.processingFormat)
        audioPlayerNode.stop()
        audioPlayerNode.scheduleFile(audioFile, at: nil, completionHandler: nil)
        do {
            try audioEngine.start()
        } catch {
            showAlert(Alerts.AudioEngineError, message: String(describing: error))
            return
        }
        
        // play the recording!
        audioPlayerNode.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SlowRate(_ sender: Any) {
        playAudioWithVariableRate(rate:0.5)

        
    }

    @IBAction func HighPitch(_ sender: Any) {
        playAudioWithVariablePitch(pitch:1000)
     
       
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
