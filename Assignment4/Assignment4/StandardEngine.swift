//
//  Engine.swift
//  Assignment4
//
//  Created by An, Unsin on 4/14/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

// for assignment 4
import Foundation
import UIKit

class StandardEngine: EngineProtocol {
    var delegate: EngineDelegate
    var grid: GridProtocol
    var refreshRate: Double = 0.0
    var refreshTimer: NSTimer?
    var rows: Int
    var cols: Int
    
    private static var engine: StandardEngine = StandardEngine(rows: 10, cols: 10)
    
    init(rows: Int, cols: Int) {
        self.grid = Grid(GridSize(rows, cols))
        self.rows = rows
        self.cols = cols
//        self.refreshRate = refreshRate
    }
    
    func step() -> GridProtocol {
        let newGrid = grid.next()
        grid = newGrid
        delegate?.engineDidUpdate(withGrid: grid)
        return grid
    }
    
    func updateNumRows(rows: Int) {
        StandardEngine.engine.rows = rows
        delegate?.engineDidUpdate(withGrid: grid)
        
        let nc = NotificationCenter.default
        let name = Notification.Name(rawValue: "EngineUpdate")
        let n = Notification(name: name, object: nil, userInfo: ["engine" : self])
        nc.post(n)
    }
    
    class func shared() -> StandardEngine {
        return engine
    }
    
}
