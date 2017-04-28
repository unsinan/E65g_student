//*********************************************************************************************************************
//
//  Grid.swift
//

import Foundation

public typealias GridPosition = (row: Int, col: Int)
public typealias GridSize = (rows: Int, cols: Int)

//fileprivate func norm(_ val: Int, to size: Int) -> Int { return ((val % size) + size) % size }

fileprivate func norm(_ val: Int, to size: Int) -> Int { return ((val % size) + size) % size }

public enum CellState: String {
    case alive = "alive"
    case empty = "empty"
    case born = "born"
    case died = "died"
    
    public var isAlive: Bool {
        switch self {
        case .alive, .born: return true
        default: return false
        }
    }
    
    public func description() -> CellState {
        switch self {
        case .alive:
            return CellState.alive
        case .born:
            return CellState.born
        case .empty:
            return CellState.empty
        case.died:
            return CellState.died
        }
    }
    
    public static func allValues() -> [CellState] {
        return [.alive, .born, .died, .empty]
    }
    
    public static func toggle(value: CellState) -> CellState {
        switch value {
        case .empty, .died:
            return .alive
        case .alive, .born:
            return .empty
        }
    }

}

public protocol GridProtocol {
    init(_ rows: Int, _ cols: Int, cellInitializer: (GridPosition) -> CellState)
    var description: String { get }
    var size: GridSize { get }
    subscript (row: Int, col: Int) -> CellState { get set }
    func next() -> Self
}

public let lazyPositions = { (size: GridSize) in
    return (0 ..< size.rows)
        .lazy
        .map { zip( [Int](repeating: $0, count: size.cols) , 0 ..< size.cols ) }
        .flatMap { $0 }
        .map { GridPosition($0) }
}


let offsets: [GridPosition] = [
    (row: -1, col:  -1), (row: -1, col:  0), (row: -1, col:  1),
    (row:  0, col:  -1),                     (row:  0, col:  1),
    (row:  1, col:  -1), (row:  1, col:  0), (row:  1, col:  1)
]

extension GridProtocol {
    public var description: String {
        return lazyPositions(self.size)
            .map { (self[$0.row, $0.col].isAlive ? "*" : " ") + ($0.col == self.size.cols - 1 ? "\n" : "") }
            .joined()
    }
    
    private func neighborStates(of pos: GridPosition) -> [CellState] {
        return offsets.map { self[pos.row + $0.row, pos.col + $0.col] }
    }
    
    private func nextState(of pos: GridPosition) -> CellState {
        let iAmAlive = self[pos.row, pos.col].isAlive
        let numLivingNeighbors = neighborStates(of: pos).filter({ $0.isAlive }).count
        switch numLivingNeighbors {
        case 2 where iAmAlive,
             3: return iAmAlive ? .alive : .born
        default: return iAmAlive ? .died  : .empty
        }
    }
    
    public func next() -> Self {
        var nextGrid = Self(size.rows, size.cols) { _, _ in .empty }
        lazyPositions(self.size).forEach { nextGrid[$0.row, $0.col] = self.nextState(of: $0) }
        return nextGrid
    }
}

public struct Grid: GridProtocol {
    private var _cells: [[CellState]]
    public let size: GridSize
    
    public subscript (row: Int, col: Int) -> CellState {
        get { return _cells[norm(row, to: size.rows)][norm(col, to: size.cols)] }
        set { _cells[norm(row, to: size.rows)][norm(col, to: size.cols)] = newValue }
    }
    
    public init(_ rows: Int, _ cols: Int, cellInitializer: (GridPosition) -> CellState = { _, _ in .empty }) {
        _cells = [[CellState]](repeatElement( [CellState](repeatElement(.empty, count: rows)), count: cols))
        size = GridSize(rows, cols)
        lazyPositions(self.size).forEach { self[$0.row, $0.col] = cellInitializer($0) }
    }
}

extension Grid: Sequence {
    fileprivate var living: [GridPosition] {
        return lazyPositions(self.size).filter { return  self[$0.row, $0.col].isAlive   }
    }
    
    public struct GridIterator: IteratorProtocol {
        private class GridHistory: Equatable {
            let positions: [GridPosition]
            let previous:  GridHistory?
            
            static func == (lhs: GridHistory, rhs: GridHistory) -> Bool {
                return lhs.positions.elementsEqual(rhs.positions, by: ==)
            }
            
            init(_ positions: [GridPosition], _ previous: GridHistory? = nil) {
                self.positions = positions
                self.previous = previous
            }
            
            var hasCycle: Bool {
                var prev = previous
                while prev != nil {
                    if self == prev { return true }
                    prev = prev!.previous
                }
                return false
            }
        }
        
        private var grid: GridProtocol
        private var history: GridHistory!
        
        init(grid: Grid) {
            self.grid = grid
            self.history = GridHistory(grid.living)
        }
        
        public mutating func next() -> GridProtocol? {
            if history.hasCycle { return nil }
            let newGrid:Grid = grid.next() as! Grid
            history = GridHistory(newGrid.living, history)
            grid = newGrid
            return grid
        }
    }
    
    public func makeIterator() -> GridIterator { return GridIterator(grid: self) }
}

public extension Grid {
    public static func gliderInitializer(pos: GridPosition) -> CellState {
        switch pos {
        case (0, 1), (1, 2), (2, 0), (2, 1), (2, 2): return .alive
        default: return .empty
        }
    }
}

//assignment 4


//public protocol GridProtocol {
//    init(_ rows: Int, _ cols: Int, cellInitializer: (GridPosition) -> CellState)
//    var description: String { get }
//    var size: GridSize { get }
//    subscript (row: Int, col: Int) -> CellState { get set }
//    func next() -> Self
//}

public protocol EngineDelegate  {
    func engineDidUpdate(withGrid: GridProtocol)
}


public protocol EngineProtocol {
    var delegate: EngineDelegate? { get set }
    var grid: GridProtocol { get set }
    var timerInterval: Double { get set }
    var timer: Timer? { get }
    var rows: Int { get }
    var cols: Int { get }
    
    init(rows: Int, cols: Int)
    func step() -> GridProtocol
}

class StandardEngine: EngineProtocol {
    var delegate: EngineDelegate?
    var grid: GridProtocol
    var timer: Timer?
    var rows: Int
    var cols: Int
    var timerInterval: TimeInterval = 0.0 {
        didSet {
            if timerInterval > 0.0 {
                timer = Timer.scheduledTimer(
                    withTimeInterval: timerInterval,
                    repeats: true
                ) { (t: Timer) in
                    _ = self.step()
                }
            }
            else {
                timer?.invalidate()
                timer = nil
            }
        }
    }

    static var engine: StandardEngine = StandardEngine(rows: 10, cols: 10)
    
    required init(rows: Int, cols: Int) {
        grid = Grid(rows,cols) //corrected
        self.rows = rows
        self.cols = cols
        delegate?.engineDidUpdate(withGrid: self.grid)
    }
    
    func step() -> GridProtocol {
//        NSLog("step")
        let newGrid = grid.next()
        grid = newGrid
        delegate?.engineDidUpdate(withGrid: self.grid)
        return grid
    }
    
    
}
