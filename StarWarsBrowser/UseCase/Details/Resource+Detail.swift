//
//  Resource+Detail.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 11/1/21.
//

import Foundation

extension Resource {
    static func details<T: Detailable>(for url: URL, page: Int, type: T.Type) -> Resource<Details<T>> {
        return Resource<Details<T>>(url: url, parameters: ["page": page])
    }
}
