//
//  SecondViewController.swift
//  Assignment1
//
//  Created by Van Simmons on 1/15/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var gridSize: UISlider!
    @IBOutlet weak var frameSecond: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        gridSize.transform = CGAffineTransform (rotationAngle: CGFloat(-M_PI_2))
        frameSecond.transform = CGAffineTransform (rotationAngle: CGFloat(-M_PI_2))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

