//
//  SimulationViewController.swift
//  FinalProject
//
//  Created by Unsin An on 4/20/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController, GridViewDataSource, EngineDelegate {
    
    @IBOutlet weak var gridView: GridView!
    @IBOutlet weak var stepButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var engine: EngineProtocol!
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        engine = Engine.engine
        gridView.gridSize = engine.grid.size.rows
        engine.delegate = self
        engine.updateClosure = { (grid) in
            self.gridView.setNeedsDisplay()
        }
        gridView.gridDataSource = self
//        sizeStepper.value = Double(engine.grid.size.rows)
        
        let nc = NotificationCenter.default
        let name = Notification.Name(rawValue: "EngineUpdate")
        nc.addObserver(
            forName: name,
            object: nil,
            queue: nil) { (n) in
                self.gridView.setNeedsDisplay()
        }
        
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        self.gridView.setNeedsDisplay()
    }
    
    public subscript (row: Int, col: Int) -> CellState {
        get { return engine.grid[row,col] }
        set { engine.grid[row,col] = newValue }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func step(_ sender: UIButton) {
        engine.step()
        gridView.setNeedsDisplay()
    }
    
    @IBAction func reset(_ sender: UIButton) {
        engine.grid = Grid(GridSize(rows: engine.grid.size.rows, cols: engine.grid.size.rows))
        gridView.setNeedsDisplay()

    }
    
    @IBAction func stop(_ sender: Any) {
        engine.timerInterval = 0.0
    }
    
    @IBAction func start(_ sender: Any) {
        engine.timerInterval = 1.0
    }
    
//    //MARK: Stepper Event Handling
//    @IBAction func step(_ sender: UIStepper) {
//        engine.grid = Grid(GridSize(rows: Int(sender.value), cols: Int(sender.value) + 5))
//        gridView.gridSize = Int(sender.value)
//        gridView.setNeedsDisplay()
//    }
    
    //MARK: AlertController Handling
    func showErrorAlert(withMessage msg:String, action: (() -> Void)? ) {
        let alert = UIAlertController(
            title: "Alert",
            message: msg,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            alert.dismiss(animated: true) { }
            OperationQueue.main.addOperation { action?() }
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
