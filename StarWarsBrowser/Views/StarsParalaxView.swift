//
//  StarsParalaxView.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/8/21.
//

import UIKit

class StarsParalaxView: UIView {
    private let subviewsNumber = 3
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
        for i in 1...subviewsNumber {
            let subview = StarsView(diameterRange: i...i+1)
            addSubview(subview)
            addConstrains(to: subview)
        }
    }
    
    private func addConstrains(to subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: topAnchor),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor),
            subview.leftAnchor.constraint(equalTo: leftAnchor),
            subview.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
//    /* Value should be in 0.0 - 1.0 range*/
//    public func doParalax(value: CGFloat) {
//
//    }
    
}
