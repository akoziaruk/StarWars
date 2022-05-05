//
//  MainNavigator.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import UIKit

protocol MainNavigator: AnyObject {
    func show(_ category: SelectedCategory)
}

