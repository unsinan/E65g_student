//
//  GridProtocol.swift
//  FinalProject
//
//  Created by Unsin An on 4/20/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

public struct GridPosition: Equatable {
    var row: Int
    var col: Int
    
    public static func == (lhs: GridPosition, rhs: GridPosition) -> Bool {
        return (lhs.row == rhs.row && lhs.col == rhs.col)
    }
}

public struct GridSize {
    var rows: Int
    var cols: Int
}

public enum CellState {
    case alive, empty, born, died
    
    public var isAlive: Bool {
        switch self {
        case .alive, .born: return true
        default: return false
        }
    }
}


public protocol GridProtocol: CustomStringConvertible {
    init(_ size: GridSize, cellInitializer: (GridPosition) -> CellState)
    var size: GridSize { get }
    subscript (row: Int, col: Int) -> CellState { get set }
    func next() -> Self
}

