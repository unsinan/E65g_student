//
//  GridView.swift
//  Assignment3
//
//  Created by An, Unsin on 3/23/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//

import UIKit

@IBDesignable class GridView: UIView {
    
    @IBInspectable var fillColor: UIColor = UIColor.clear
    // cell colors
    @IBInspectable var livingColor: UIColor = UIColor.green
    @IBInspectable var emptyColor: UIColor = UIColor.darkGray
    @IBInspectable var bornColor: UIColor = UIColor.green.withAlphaComponent(0.6)
    @IBInspectable var diedColor: UIColor = UIColor.darkGray.withAlphaComponent(0.6)
    @IBInspectable var gridColor: UIColor = UIColor.black
    @IBInspectable var gridWidth: CGFloat = 2.0
    @IBInspectable var size: Int = 20 {
        didSet {
            grid = Grid(size, size)
        }
    }
    
    var xColor = UIColor.black
    var xProportion = CGFloat(1.0)
    var widthProportion = CGFloat(0.05)
    
    var grid = Grid(20,20)
//    var cells: [[Cell]]
    
    override func draw(_ rect: CGRect) {
        let size = CGSize(
            width: rect.size.width / CGFloat(self.size),
            height: rect.size.height / CGFloat(self.size)
        )
        let base = rect.origin
        (0 ..< self.size).forEach { i in
            (0 ..< self.size).forEach { j in
//                if let state = cells[i,j].state {
                    let origin = CGPoint(
                        x: base.x + (CGFloat(j) * size.width),
                        y: base.y + (CGFloat(i) * size.height)
                    )
                    let cell = CGRect(
                        origin: origin,
                        size: size
                    )
                // draw circles
//                if grid[(i,j)].isAlive {
//                      let path = UIBezierPath(ovalIn: cell)
//                      fillColor.setFill()
//                      path.fill()
//            }
                    let path = UIBezierPath(ovalIn: cell)
                    switch grid[(i,j)].description() {
                    case .empty:
                        emptyColor.setFill()
                    case .born:
                        bornColor.setFill()
                    case .alive:
                        livingColor.setFill()
                    case .died:
                        diedColor.setFill()
                    default:
                        emptyColor.setFill()
                    }
                    path.fill()
            }
        }
        
        //create the path
        (0 ..< (self.size + 1)).forEach {
            drawLine(
                start: CGPoint(x: CGFloat($0)/CGFloat(self.size) * rect.size.width, y: 0.0),
                end:   CGPoint(x: CGFloat($0)/CGFloat(self.size) * rect.size.width, y: rect.size.height)
            )
            
            drawLine(
                start: CGPoint(x: 0.0, y: CGFloat($0)/CGFloat(self.size) * rect.size.height ),
                end: CGPoint(x: rect.size.width, y: CGFloat($0)/CGFloat(self.size) * rect.size.height)
            )
        }
    }
    func drawLine(start:CGPoint, end: CGPoint) {
        let path = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        path.lineWidth = 2.0
        
        //move the initial point of the path
        //to the start of the horizontal stroke
        path.move(to: start)
        
        //add a point to the path at the end of the stroke
        path.addLine(to: end)
        
        //draw the stroke
        UIColor.cyan.setStroke()
        path.stroke()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchedPosition = process(touches: touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchedPosition = process(touches: touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchedPosition = nil
    }
    
    typealias Position = (row: Int, col: Int)
    var lastTouchedPosition: Position?
    
    func process(touches: Set<UITouch>) -> Position? {
        guard touches.count == 1 else { return nil }
        let position = convert(touch: touches.first!)
        guard lastTouchedPosition?.row != position.row
            || lastTouchedPosition?.col != position.col
            else { return position }
        
        // replace with toggle method -- update
//        grid[position] = grid[position].isAlive ? .empty : .alive
        grid[position] = CellState.toggle(value: grid[position])
        setNeedsDisplay()
        return position
    }
    
    func convert(touch: UITouch) -> Position {
        let touchY = touch.location(in: self).y
        let gridHeight = frame.size.height
        let row = touchY / gridHeight * CGFloat(size)
        let touchX = touch.location(in: self).x
        let gridWidth = frame.size.width
        let col = touchX / gridWidth * CGFloat(size)
        let position = (row: Int(row), col: Int(col))
        return position
    }
}


