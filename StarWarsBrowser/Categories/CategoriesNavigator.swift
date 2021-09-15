//
//  CategoriesNavigator.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/31/21.
//

import Foundation

protocol CategoriesNavigator: AnyObject {
    func showDetails(forCategory id: String)
}