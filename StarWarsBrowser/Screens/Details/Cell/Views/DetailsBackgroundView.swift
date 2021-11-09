//
//  DetailsBackgroundView.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/18/21.
//

import Foundation
import UIKit

class DetailsBackgroundView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = Constants.cornerRadius
        layer.borderColor = Constants.borderColor.cgColor
        layer.borderWidth = Constants.borderWidth
        layer.masksToBounds = true

        backgroundColor = Constants.backgroundColor
    }
    
    struct Constants {
        static let backgroundColor = UIColor(red: 0.138, green: 0.138, blue: 0.138, alpha: 0.9)
        static let borderColor = UIColor(red: 0.157, green: 0.157, blue: 0.157, alpha: 1)
        static let cornerRadius = 13.0
        static let borderWidth = 1.0
    }
        
}
