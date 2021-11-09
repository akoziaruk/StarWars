//
//  CategoryGradientView.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/12/21.
//

import Foundation
import UIKit

/* CategoryGradientView creates backgorund view with gradient used in category cell */
class CategoryGradientView: UIView {
    var selectionLayer: CALayer! = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        
        clipsToBounds = true
        layer.cornerRadius = Constants.cornerRadius
                 
        addStaticBorder()
        addSelectionLayer()
        addSelectionBackground()
        addSelectionBorder()
        addSelectionShadow()
    }
    
    public func set(selected: Bool) {
        selectionLayer.isHidden = !selected
    }
    
    private func addSelectionLayer() {
        selectionLayer = CALayer()
        selectionLayer.frame = bounds
        layer.addSublayer(selectionLayer)
    }
    
    private func addSelectionBackground() {
        let backgroundLayer = CAGradientLayer()
        
        backgroundLayer.colors = [Constants.yellowColor.withAlphaComponent(0.15).cgColor,
                                  Constants.grayColor.withAlphaComponent(0).cgColor]
        
        backgroundLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        backgroundLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        backgroundLayer.frame = bounds
        
        selectionLayer.addSublayer(backgroundLayer)
    }
    
    private func addSelectionBorder() {
        let borderLayer = CAGradientLayer()
        
        borderLayer.frame = CGRect(x: bounds.origin.x,
                                   y: bounds.origin.y,
                                   width: bounds.size.width + Constants.borderWidth,
                                   height: bounds.size.height + Constants.borderWidth)
        
        borderLayer.colors = [Constants.yellowColor.cgColor,
                              Constants.grayColor.withAlphaComponent(0).cgColor]
        
        borderLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        borderLayer.endPoint = CGPoint(x: 0.0, y: 1.0)

        let mask = CAShapeLayer()
        
        let maskRect = CGRect(x: bounds.origin.x + Constants.borderWidth/2,
                              y: bounds.origin.y + Constants.borderWidth/2,
                              width: bounds.size.width - Constants.borderWidth,
                              height: bounds.size.height - Constants.borderWidth)
        
        mask.path = UIBezierPath(roundedRect: maskRect,
                                 cornerRadius: Constants.cornerRadius).cgPath
        
        mask.fillColor = UIColor.clear.cgColor
        mask.strokeColor = UIColor.white.cgColor
        mask.lineWidth = Constants.borderWidth
        
        borderLayer.mask = mask

        selectionLayer.addSublayer(borderLayer)
    }

    private func addSelectionShadow() {
        let shadowPath = UIBezierPath(roundedRect: bounds,
                                      cornerRadius: Constants.cornerRadius)
        
        let shadowLayer = CALayer()
        
        shadowLayer.shadowPath = shadowPath.cgPath
        shadowLayer.shadowColor = Constants.shadowColor.cgColor
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowRadius = 16
        shadowLayer.shadowOffset = CGSize(width: 0, height: 16)
        shadowLayer.bounds = bounds
        
        selectionLayer.addSublayer(shadowLayer)
    }
    
    private func addStaticBorder() {
        let borderLayer = CALayer()
        
        borderLayer.frame = bounds
        borderLayer.borderWidth = Constants.borderWidth
        borderLayer.borderColor = Constants.grayColor.cgColor
        borderLayer.cornerRadius = Constants.cornerRadius
        
        layer.addSublayer(borderLayer)
    }
    
    struct Constants {
        static let yellowColor = UIColor(red: 1, green: 0.984, blue: 0.071, alpha: 1)
        static let grayColor = UIColor(red: 0.165, green: 0.165, blue: 0.165, alpha: 1)
        static let shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        static let cornerRadius = 12.0
        static let borderWidth = 1.0
    }
}
