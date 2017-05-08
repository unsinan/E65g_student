//
//  GridEditor.swift
//  FinalProject
//
//  Created by An, Unsin on 5/1/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

class GridEditorViewController: UIViewController {
    
    var saveClosure: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func save(_ sender: UIButton) {
//        if let newValue = engine.grid,
//            let saveClosure = saveClosure {
//                saveClosure(newValue)
//                self.navigationController?.popViewController(animated: true)  // go back without having to manually click on back
//            }
    }
}
