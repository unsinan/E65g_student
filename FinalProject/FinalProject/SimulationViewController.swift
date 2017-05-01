//
//  SimulationViewController.swift
//  FinalProject
//
//  Created by Unsin An on 4/20/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController, EngineDelegate {
    
    @IBOutlet weak var gridView: GridView!
    @IBOutlet weak var stepButton: UIButton!
    
    var engine: StandardEngine!
    //    var delegate: EngineDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let size = gridView.size
        engine = StandardEngine(rows: size, cols: size)
        engine.delegate = self
        //        gridView.grid = self
        
        let nc = NotificationCenter.default
        let name = Notification.Name(rawValue: "EngineUpdate")
        nc.addObserver(
            forName: name,
            object: nil,
            queue: nil) { (n) in
                self.gridView.setNeedsDisplay()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        self.gridView.setNeedsDisplay()
    }
    
    //    @IBAction func step(_ sender: Any) {
    //        engine.grid = Grid(GridSize(rows: Int(sender.value), cols: Int(sender.value)))
    //        gridView.size = Int(sender.value)
    //        gridView.setNeedsDisplay()
    //    }
    
    //corrected
    //MARK: UIButton Event Handling
    @IBAction func step(_ sender: UIButton) {
        //        engine.grid = engine.grid.next()
        engine.grid = engine.step()
        gridView.setNeedsDisplay()
    }
    
    
}


