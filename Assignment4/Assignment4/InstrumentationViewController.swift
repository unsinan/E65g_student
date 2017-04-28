//
//  InstrumentationViewController.swift
//  Assignment4
//
//  Created by An, Unsin on 4/13/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController {

    @IBOutlet weak var rowsDisplay: UITextField!
    @IBOutlet weak var rowsStepper: UIStepper!
    @IBOutlet weak var colsDisplay: UITextField!
    @IBOutlet weak var colsStepper: UIStepper!
    @IBOutlet weak var RrefreshRate: UISlider!
    @IBOutlet weak var refreshSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        rowsStepper.value = Double(engine.grid.size.rows)
//        colsStepper.value = Double(engine.grid.size.cols)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func rowStep(_ sender: UIStepper) {
    }
    
    @IBAction func colStep(_ sender: UIStepper) {
    }
    
    // MARK: - TextField Event Handling
    
    @IBAction func rowEditingBegan(_ sender: UITextField) {
    }
    
    @IBAction func rowEditingChanged(_ sender: UITextField) {
    }
    
    @IBAction func rowEditingEndedOnExit(_ sender: UITextField) {
    }
    
    @IBAction func rowEditingEnded(_ sender: UITextField) {
    }
    
    @IBAction func rowTriggeredAction(_ sender: UITextField) {
    }
    
    @IBAction func colEditingBegan(_ sender: UITextField) {
    }
    
    @IBAction func colEditingChanged(_ sender: UITextField) {
    }
    
//    @IBAction func colEditingEndedOnExit(_ sender: UITextField) {
//        guard let text = sender.text else {return }
//        guard let val = Int(text) else {
//            showErrorAlert(withMessage: "Invalid value: \(text), please try again.") {
//                sender.text = "\(self.engine.gridSize)"
//            }
//            return
//        }
//        gridView.gridSize = value
//        grid = Grid(rows, cols)
//        gridView.setNeedsDisplay()
//    }
    
    @IBAction func colEditingEnded(_ sender: UITextField) {
    }
    
    @IBAction func colTriggeredAction(_ sender: UITextField) {
    }
    
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
