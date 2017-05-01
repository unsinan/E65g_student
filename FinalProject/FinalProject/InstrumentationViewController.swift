//
//  InstrumentationViewController.swift
//  FinalProject
//
//  Created by Unsin An on 4/20/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

    var sectionHeaders = [
        "One", "Two", "Three", "Four", "Five", "Six"
    ]
    
    var data = [
        [
            "Apple",
            "Banana",
            "Cherry",
            "Date",
            "Kiwi",
            "Apple",
            "Banana",
            "Cherry",
            "Date"
        ],
        [
            "Kiwi",
            "Apple",
            "Banana",
            "Cherry",
            "Date",
            "Kiwi",
            "Apple",
            "Banana",
            "Cherry",
            "Date",
            "Kiwi",
            "Apple",
            "Banana"
        ],
        [
            "Cherry",
            "Date",
            "Kiwi",
            "Apple",
            "Banana",
            "Cherry",
            "Date",
            "Kiwi",
            "Apple",
            "Banana",
            "Cherry",
            "Date",
            "Kiwi",
            "Apple",
            "Banana",
            "Cherry",
            "Date",
            "Kiwi",
            "Apple",
            "Banana",
            "Cherry"
        ],
        [
            "Date",
            "Kiwi",
            "Apple",
            "Banana",
            "Cherry",
            "Date",
            "Kiwi",
            "Apple",
            "Banana",
            "Cherry",
            "Date",
            "Kiwi",
            "Apple",
            "Banana",
            "Cherry",
            "Date",
            "Kiwi",
            "Blueberry"
        ]
    ]

class InstrumentationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let identifier = indexPath.item % 2 == 0 ? "basic" : "green"
        let identifier = "basic"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let label = cell.contentView.subviews.first as! UILabel
        label.text = data[indexPath.section][indexPath.item]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var newData = data[indexPath.section]
            newData.remove(at: indexPath.row)
            data[indexPath.section] = newData
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaders[section]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPathForSelectedRow
        if let indexPath = indexPath {
            let fruitValue = data[indexPath.section][indexPath.row]
            if let vc = segue.destination as? GridEditorViewController {
                vc.fruitValue = fruitValue
                vc.saveClosure = { newValue in
                    data[indexPath.section][indexPath.row] = newValue
                    self.tableView.reloadData()
                }
            }
        }
    
    }
}
