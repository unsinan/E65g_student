//
//  EngineDelegate.swift
//  Assignment4
//
//  Created by An, Unsin on 4/14/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

public protocol EngineDelegateProtocol  {
    var description: String { get }
    var size: GridSize { get }
    subscript (row: Int, col: Int) -> CellState { get set }
    func next() -> Self
}
