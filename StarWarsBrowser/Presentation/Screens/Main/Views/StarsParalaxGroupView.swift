//
//  StarsParalaxGroupView.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/8/21.
//

import UIKit

/* StarsParalaxGroupView creates view of stars with paralax effect on scrolling */
class StarsParalaxGroupView: UIView {
    private struct Constants {
        static let velocity = 20.0
        static let layersCount = 3
        static let starsCount = 160
    }
    
    private var lastOffset = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
              
        setupLayers()
    }
    
    private func setupLayers() {
        for i in 1...Constants.layersCount {
            let f = CGFloat(i-1)
            let view = StarsInfiniteView(diameterRange: f...f+0.5,
                                            starsCount: Constants.starsCount*i)
            addSubview(view)
            view.constraintEqual(to: self)
        }
    }

    public func doParalax(with offset: CGFloat) {
        for (index, view) in subviews.enumerated() {
            let k = CGFloat(subviews.count-index)
            let delta = (offset-lastOffset) / (Constants.velocity*k)
            (view as! StarsInfiniteView).move(by: delta)
        }
        lastOffset = offset
    }
}
