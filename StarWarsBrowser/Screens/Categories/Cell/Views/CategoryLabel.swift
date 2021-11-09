//
//  CategoryLabel.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/13/21.
//

import Foundation
import UIKit

class CategoryLabel: UILabel {
    public func set(selected: Bool) {
        textColor = selected ? Constants.selectedColor: Constants.deselectedColor
    }
    
    struct Constants {
        static let selectedColor = UIColor.white
        static let deselectedColor = UIColor(red: 0.434, green: 0.434, blue: 0.434, alpha: 1)
    }
    
}
