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

    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            print (jsonTitle, jsonContents)

            //            OperationQueue.main.addOperation {
            //                self.textField.text = resultString
            //            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    
//    @IBAction func addRowToTop(_ sender: UIButton) {
//        data[0] = ["New Fruity Thing"] + data[0]
//        self.tableView.reloadData()
//    }
    
    //MARK: TableView DataSource and Delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        return data.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return jsonContents.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "basic"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let label = cell.contentView.subviews.first as! UILabel
        label.text = jsonTitle //[indexPath.section][indexPath.item]
//        label.text = jsonDictionary[indexPath.section][indexPath.item]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return jsonTitle
//        return "test"
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

