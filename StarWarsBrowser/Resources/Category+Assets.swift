//
//  Category+Assets.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/11/21.
//

import Foundation
import UIKit

extension Category {
    var image: UIImage {
        switch type {
        case .films:
            return #imageLiteral(resourceName: "films")
        case .people:
            return #imageLiteral(resourceName: "people")
        case .planets:
            return #imageLiteral(resourceName: "planets")
        case .species:
            return #imageLiteral(resourceName: "species")
        case .starships:
            return #imageLiteral(resourceName: "starships")
        case .vehicles:
            return #imageLiteral(resourceName: "vehicles")
        case .unknown:
            return #imageLiteral(resourceName: "films")
        }
    }
}
