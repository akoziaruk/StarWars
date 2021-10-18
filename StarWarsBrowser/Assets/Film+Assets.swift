//
//  Film+Assets.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/18/21.
//

import Foundation
import UIKit

extension Film {
    var image: UIImage? {
        switch title {
        case "A New Hope":
            return #imageLiteral(resourceName: "a_new_hope")
        case "The Empire Strikes Back":
           return #imageLiteral(resourceName: "the_empire_strikes_back")
        case "Return of the Jedi":
           return #imageLiteral(resourceName: "return_of_the_jedi")
        case "The Phantom Menace":
           return #imageLiteral(resourceName: "the_phantom_menace")
        case "Attack of the Clones":
           return #imageLiteral(resourceName: "attack_of_the_clones")
        case "Revenge of the Sith":
           return #imageLiteral(resourceName: "revange_of_sith")
        default:
            return nil
        }
    }
}
