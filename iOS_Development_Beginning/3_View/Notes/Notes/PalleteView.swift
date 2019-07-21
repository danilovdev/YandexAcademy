//
//  PalleteView.swift
//  Notes
//
//  Created by Alexey Danilov on 7/14/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import UIKit


class PalleteView: UIView {
    
    func getPointForColor(color: UIColor) -> CGPoint? {
        let rectWidth = bounds.width
        let rectHeight = bounds.height
        
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        var hue: CGFloat = 0
        
        color.getHue(&hue,
                     saturation: &saturation,
                     brightness: &brightness,
                     alpha: &alpha)
        
        let x = hue * rectWidth
        let y = saturation * rectHeight
        
        return CGPoint(x: x, y: y)
    }
    
    func getColor(at point: CGPoint) -> UIColor? {
        let x = point.x
        let y = point.y
        let rectWidth = bounds.width
        let rectHeight = bounds.height
        let hue = x / rectWidth
        let saturation = y / rectHeight
        let color = UIColor(
            hue: hue,
            saturation: saturation,
            brightness: brightness ?? 1.0,
            alpha: 1.0
        )
        return color
    }
    
    var brightness: CGFloat? {
        didSet {
            if brightness != nil {
                setNeedsDisplay()
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
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
                    brightness: brightness ?? 1.0,
                    alpha: 1.0
                )
                context.setFillColor(color.cgColor)
                context.fill(CGRect(x: x, y: y, width: elementWidth, height: elementHeight))
            }
        }
    }
}
