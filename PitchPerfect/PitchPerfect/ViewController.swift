//
//  ViewController.swift
//  PitchPerfect
//
//  Created by ZhouYiqin on 6/27/17.
//  Copyright © 2017 Yiqin Zhou. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

 
    
    @IBOutlet weak var Record: UIButton!
    
    
    @IBOutlet weak var Stop: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func StartRecording(_ sender: UIButton) {
        

    }
    
    
    @IBAction func StopRecording(_ sender: UIButton) {
    }
       

}
    

