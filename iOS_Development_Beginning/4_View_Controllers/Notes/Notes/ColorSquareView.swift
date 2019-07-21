//
//  ColorSquareView.swift
//  Notes
//
//  Created by Alexey Danilov on 7/14/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import UIKit

enum ColorSquareViewType {
    
    case normalColor(color: UIColor)
    
    case pallete
}


class ColorSquareView: UIView {
    
    var isSelected: Bool? {
        didSet {
            if let isSelected = isSelected  {
                isSelected ? createCircle() : (circlePath = nil)
                setNeedsDisplay()
            }
        }
    }
    
    private var circlePath: UIBezierPath!
    
    var type: ColorSquareViewType? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.backgroundColor = UIColor.black.cgColor
        layer.borderWidth = 2.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.backgroundColor = UIColor.black.cgColor
        layer.borderWidth = 2.0
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        guard let type = type else { return }
        
        switch type {
        case .normalColor(let color):
            
            color.setFill()
            context.fill(rect);
            
            let padding = bounds.width / 20
            let width = bounds.width / 2.5
            let height = width
            
            if circlePath != nil {
                UIColor.clear.setFill()
                circlePath.fill()

                // Specify a border (stroke) color.
                UIColor.black.setStroke()
                circlePath.lineWidth = 2.0
                circlePath.stroke()
                
                let firstPoint = CGPoint(x: bounds.maxX - width - padding,
                                         y: bounds.minY + padding + height / 2)
                let secondPoint = CGPoint(x: bounds.maxX - width - padding + width / 2 ,
                                          y: bounds.minY + height)
                let thirdPoint = CGPoint(x: bounds.maxX - padding - width / 4,
                                         y: bounds.minY + padding)
                
                
                UIGraphicsGetCurrentContext()?.setLineWidth(2.0)
                UIColor.black.setStroke()
                UIGraphicsGetCurrentContext()?.move(to: firstPoint)
                UIGraphicsGetCurrentContext()?.addLine(to: secondPoint)
                UIGraphicsGetCurrentContext()?.addLine(to: thirdPoint)
                UIGraphicsGetCurrentContext()?.strokePath()
            }
        case .pallete:
            let rectSize = rect.size
            let rectHeight = rectSize.height
            let rectWidth = rectSize.width
            let elementWidth = CGFloat(1.0)
            let elementHeight = CGFloat(1.0)
            
            for x: CGFloat in stride(from: 0.0, to: rectWidth, by: elementWidth) {
                for y: CGFloat in stride(from: 0.0, to: rectHeight, by: elementHeight) {
                    let hue = x / rectWidth
                    let saturation = y / rectHeight
                    let color = UIColor(
                        hue: hue,
                        saturation: saturation,
                        brightness: 1.0,
                        alpha: 1.0
                    )
                    context.setFillColor(color.cgColor)
                    context.fill(CGRect(x: x, y: y, width: elementWidth, height: elementHeight))
                }
            }
        }
    }
    
    func createCircle() {
        // Initialize the path.
        let padding = bounds.width / 20
        let width = bounds.width / 2.5
        let height = width
        circlePath = UIBezierPath(ovalIn: CGRect(x: bounds.maxX - width - padding,
                                           y: bounds.minY + padding,
                                           width: width,
                                           height: height))

    }
    
}
