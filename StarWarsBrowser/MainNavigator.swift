//
//  MainNavigator.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import UIKit

protocol MainNavigator: AnyObject {
    func showCategory(for type: ItemType, url: URL)
}

