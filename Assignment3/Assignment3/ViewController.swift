//
//  ViewController.swift
//  Assignment3
//
//  Created by Van Simmons on 1/15/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {


    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var gridView: GridView!
    
    //this is your audio playback instance
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func resetButton(_ sender: Any) {
        gridView.grid = Grid(gridView.size, gridView.size)
        gridView.setNeedsDisplay()
        
        // stop playing music
        audioPlayer.stop()
    }

    @IBAction func myActionButton(_ sender: Any) {
        gridView.grid = gridView.grid.next()
        gridView.setNeedsDisplay()
        
        
        // play music
        do
        {
            let audioPath = Bundle.main.path(forResource: "Two-Step2", ofType: "mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        }
        catch
        {
        }
        
        audioPlayer.play()

    }

    /*  FROM THE SESSION 6
     var myInt : Int = 0 {
     
     didSet {
     print ("Old value is \(oldValue)")
     print ("New value is \(myInt)")
     }
     
     willSet {
     myInt2 = newValue
     }
     }
     
     for computed properties
     set
     
     var myInt2 : Int = 0
     */
}

