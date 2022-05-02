//
//  UIView+Utils.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 29.04.2022.
//

import UIKit

extension UIView {
    func constraintEqual(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [view.leftAnchor.constraint(equalTo: leftAnchor),
                           view.topAnchor.constraint(equalTo: topAnchor),
                           view.bottomAnchor.constraint(equalTo: bottomAnchor),
                           view.rightAnchor.constraint(equalTo: rightAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
}
