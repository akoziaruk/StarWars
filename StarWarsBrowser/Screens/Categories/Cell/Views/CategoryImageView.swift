//
//  CategoryImageView.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/12/21.
//

import Foundation
import UIKit

class CategoryImageView: UIImageView {
    public func set(selected: Bool) {
        let color = selected ? Constants.selectedImageColor: Constants.deselectedImageColor
        setImage(color: color)
    }
    
    struct Constants {
        static let selectedImageColor = UIColor(red: 1, green: 0.984, blue: 0.071, alpha: 1)
        static let deselectedImageColor = UIColor(red: 0.346, green: 0.346, blue: 0.346, alpha: 1)
    }
}
