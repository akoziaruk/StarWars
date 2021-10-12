//
//  UIImageView+Extentions.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/12/21.
//

import Foundation
import UIKit

extension UIImageView {
    func setImage(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
