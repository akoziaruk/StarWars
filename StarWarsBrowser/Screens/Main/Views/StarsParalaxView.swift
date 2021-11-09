//
//  StarsParalaxView.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/8/21.
//

import UIKit

/* StarsParalaxView creates view of stars with paralax effect on scrolling */
class StarsParalaxView: UIView {
    private let layersCount = 3
    private let widthCompensation = 600.0
    private let baseLayerStarsCount = 200
    private let velocity = 20.0
    private var lastOffset = 0.0
    
    private var paralaxConstraints = [NSLayoutConstraint]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
              
        setupLayers()
    }
    
    private func setupLayers() {
        for i in 1...layersCount {
            let f = CGFloat(i-1)
            let subview = StarsView(diameterRange: f...f+0.5,
                                    starsCount: baseLayerStarsCount*i)
            addSubview(subview)
            setupConstrains(to: subview)
        }
    }

    private func setupConstrains(to subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let centerConstraint = subview.centerXAnchor.constraint(equalTo: centerXAnchor)
        paralaxConstraints.append(centerConstraint)
        
        let constraints = [centerConstraint,
                           subview.topAnchor.constraint(equalTo: topAnchor),
                           subview.bottomAnchor.constraint(equalTo: bottomAnchor),
                           subview.widthAnchor.constraint(equalTo: widthAnchor,
                                                          constant: widthCompensation)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    public func doParalax(with offset: CGFloat) {
        for (index, constraint) in paralaxConstraints.enumerated() {
            let k = CGFloat(paralaxConstraints.count-index)
            let delta = (offset-lastOffset)/(velocity*k)
            constraint.constant = constraint.constant+delta
        }
        lastOffset = offset
    }
    
}
