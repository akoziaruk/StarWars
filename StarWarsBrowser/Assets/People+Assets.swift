//
//  People+Assets.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/19/21.
//

import Foundation
import UIKit

extension People {
    var image: UIImage? {
        switch name {
        case "Luke Skywalker":
            return #imageLiteral(resourceName: "luke_skywalker")
        default:
            return nil
        }
    }
}
