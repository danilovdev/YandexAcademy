//
//  ColorPicker.swift
//  Notes
//
//  Created by Alexey Danilov on 7/14/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import Foundation
import UIKit

class ColorPicker: UIView {
    
    @IBOutlet weak var targetImageView: UIImageView! {
        didSet {
            targetImageView.image = UIImage(named: "target")?.withRenderingMode(.alwaysTemplate)
            targetImageView.tintColor = .black
            targetImageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            targetImageView.contentMode = .scaleToFill
            targetImageView.clipsToBounds = true
        }
    }
    
    private var selectedPoint: CGPoint? {
        didSet {
            if let selectedPoint = selectedPoint {
                targetImageView.isHidden = false
                targetImageView.center = selectedPoint
            }
        }
    }
    
    @IBOutlet weak var slider: UISlider! {
        didSet {
            slider.isContinuous = false
        }
    }
    
    @IBOutlet weak var palleteView: PalleteView! {
        didSet {
            palleteView.layer.borderColor = UIColor.black.cgColor
            palleteView.layer.borderWidth = 2
        }
    }
    
    @IBOutlet weak var selectedColorContainer: UIView! {
        didSet {
            selectedColorContainer.layer.cornerRadius = 10
            selectedColorContainer.layer.borderColor = UIColor.black.cgColor
            selectedColorContainer.layer.borderWidth = 2
            selectedColorContainer.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var selectedColorView: UIView! {
        didSet {
            selectedColorView.layer.borderColor = UIColor.black.cgColor
            selectedColorView.layer.borderWidth = 2
            selectedColorView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var selectedColorLabel: UILabel!
    
    var selectedColor: UIColor? {
        didSet {
            if let unwrappedColor = selectedColor {
                selectedColorView.backgroundColor = unwrappedColor
                selectedColorLabel.text = unwrappedColor.toHex()
                
                var saturation: CGFloat = 0
                var brightness: CGFloat = 0
                var alpha: CGFloat = 0
                var hue: CGFloat = 0
                
                unwrappedColor.getHue(&hue,
                                      saturation: &saturation,
                                      brightness: &brightness,
                                      alpha: &alpha)
                
                slider.setValue(Float(brightness), animated: false)
                selectedPoint = palleteView.getPointForColor(color: unwrappedColor)
            }
        }
    }
    
    var doneHandler: ((_ selectedColor: UIColor?) -> Void)?
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        doneHandler?(selectedColor)
    }
    
    @IBAction func sliderChanged(_ slider: UISlider) {
        palleteView.brightness = CGFloat(slider.value)
        if let selectedPoint = selectedPoint {
            let color = palleteView.getColor(at: selectedPoint)
            selectedColor = color
        }
    }
    
    @IBAction func tapRecognizerHandled(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: palleteView)
        if let color = palleteView.getColor(at: point) {
            selectedColor = color
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        let xibView = loadViewFromXib()
        xibView.frame = bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(xibView)
    }
    
    private func loadViewFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ColorPicker", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first! as! UIView
    }
}
