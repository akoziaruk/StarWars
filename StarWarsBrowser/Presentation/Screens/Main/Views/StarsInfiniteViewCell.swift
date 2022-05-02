//
//  StarsInfiniteViewCell.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 29.04.2022.
//

import UIKit

class StarsInfiniteViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    
        contentView.subviews.first?.removeFromSuperview()
    }
    func set(view: UIView) {
        contentView.addSubview(view)
        view.constraintEqual(to: contentView)
    }
        
    struct Constants {
        static let identifier = "starCell"
    }
}
