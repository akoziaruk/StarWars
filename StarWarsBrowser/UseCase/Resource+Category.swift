//
//  Resource+Category.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/31/21.
//

import Foundation

extension Resource {
    
    static func categories() -> Resource<Categories> {
        return Resource<Categories>(url: APIConstants.baseURL)
    }
    
}
