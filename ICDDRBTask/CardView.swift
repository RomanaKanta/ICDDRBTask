//
//  CardView.swift
//  ICDDRBTask
//
//  Created by Romana on 27/10/22.
//

import UIKit

@IBDesignable class CardView: UIView {
    
    @IBInspectable var cornerradius: CGFloat = 5.0 { didSet{ updateUI() } }
    @IBInspectable var bgColor: UIColor = UIColor.white { didSet{ updateUI() } }
    
    var shadowOffSetWidth : CGFloat = 0
    var shadowOffSetHeight : CGFloat = 4 { didSet{ updateUI() } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initCustomView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initCustomView()
    }
    
    func initCustomView() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }
    
    override func layoutSubviews() {
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerradius)
        layer.shadowPath = shadowPath.cgPath
        updateUI()
    }
    
    func updateUI() {
        
        layer.cornerRadius = cornerradius
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerradius)
        self.backgroundColor = bgColor
        layer.shadowPath = shadowPath.cgPath
        
        setNeedsDisplay()
    }
    
}

