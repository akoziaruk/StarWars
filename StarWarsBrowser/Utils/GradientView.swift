//
//  GradientView.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 16.01.2022.
//

import UIKit

@IBDesignable class GradientView: UIView {
    @IBInspectable var startColor: UIColor = UIColor.white
    @IBInspectable var endColor: UIColor = UIColor.white

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [startColor.cgColor, endColor.cgColor]
    }
}
