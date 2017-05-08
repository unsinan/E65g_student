//
//  InstrumentationViewController.swift
//  FinalProject
//
//  Created by Unsin An on 4/20/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit
import Foundation

    let finalProjectURL = "https://dl.dropboxusercontent.com/u/7544475/S65g.json"

    var json: Any?
    var jsonArray: NSArray?
    var jsonDictionary: NSDictionary?
    var jsonTitle: String?
    var jsonContents: [[Int]]?

class InstrumentationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var size: UITextField!
    @IBOutlet weak var sizeStepper: UIStepper!
    @IBOutlet weak var refreshRate: UISlider!
    @IBOutlet weak var timerSwitch: UISwitch!
    
    var engine: EngineProtocol!
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        engine = Engine.engine
//        gridView.gridSize = engine.grid.size.rows
//        engine.delegate = self
//        engine.updateClosure = { (grid) in
//            self.gridView.setNeedsDisplay()
//        }
//        gridView.gridDataSource = self
//                sizeStepper.value = Double(engine.grid.size.rows)
//        
//        let nc = NotificationCenter.default
//        let name = Notification.Name(rawValue: "EngineUpdate")
//        nc.addObserver(
//            forName: name,
//            object: nil,
//            queue: nil) { (n) in
//                self.gridView.setNeedsDisplay()
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let fetcher = Fetcher()
        fetcher.fetchJSON(url: URL(string:finalProjectURL)!) { (json: Any?, message: String?) in
            guard message == nil else {
                print(message ?? "nil")
                return
            }
            guard let json = json else {
                print("no json")
                return
            }
//            print(json)
            //            let resultString = (json as AnyObject).description
//            let jsonArray = json as! NSArray
//            self.jsonArray = json as! NSArray
//            self.jsonDictionary = self.jsonArray[0] as! NSDictionary
//            self.jsonTitle = self.jsonDictionary["title"] as! String
//            self.jsonContents = self.jsonDictionary["contents"] as! [[Int]]
//            print (self.jsonTitle, self.jsonContents)
            
            jsonArray = json as? NSArray
            jsonDictionary = jsonArray?[0] as? NSDictionary
            jsonTitle = jsonDictionary?["title"] as? String
            jsonContents = jsonDictionary?["contents"] as? [[Int]]
//            print (jsonTitle, jsonContents)

            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func size(_ sender: UITextField) {
    }

    @IBAction func sizeStepper(_ sender: UIStepper) {
        engine.grid = Grid(GridSize(rows: Int(sender.value), cols: Int(sender.value) + 5))
//        gridView.gridSize = Int(sender.value)
//        gridView.setNeedsDisplay()
    }
    
    @IBAction func refreshRate(_ sender: UISlider) {
    }
    
    @IBAction func timerSwitch(_ sender: UISwitch) {
    }
    
    //MARK: TableView DataSource and Delegate
//    @IBAction func stop(_ sender: Any) {
//        engine.timerInterval = 0.0
//    }
//    
//    @IBAction func start(_ sender: Any) {
//        engine.timerInterval = 1.0
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        return data.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return jsonContents!.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "basic"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let label = cell.contentView.subviews.first as! UILabel
//        label.text = jsonDictionary[indexPath.section][indexPath.item]
//        label.text = jsonTitle
        label.text = "title"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return jsonTitle
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            var newData = data[indexPath.section]
//            newData.remove(at: indexPath.row)
//            data[indexPath.section] = newData
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//            tableView.reloadData()
//        }
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let indexPath = tableView.indexPathForSelectedRow
//        if let indexPath = indexPath {
//            let fruitValue = data[indexPath.section][indexPath.row]
//            if let vc = segue.destination as? GridEditorViewController {
//                vc.fruitValue = fruitValue
//                vc.saveClosure = { newValue in
//                    data[indexPath.section][indexPath.row] = newValue
//                    self.tableView.reloadData()
//                }
//            }
//        }
//    }
}

