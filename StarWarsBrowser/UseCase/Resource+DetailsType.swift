//
//  Resource+DetailsType.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import Foundation

extension Resource {    
    static func films(with url: URL) -> Resource<Film> {
        return Resource<Film>(url: url)
    }
}
