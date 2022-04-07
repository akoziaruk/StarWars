//
//  Resource+Detail.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 11/1/21.
//

import Foundation

extension Resource {
    static func films(for url: URL, page: Int) -> Resource<FilmsDTO> {
        return Resource<FilmsDTO>(url: url, parameters: ["page": page])
    }
    
    static func defaultDetails(for url: URL, page: Int) -> Resource<DefaultDetailsDTO> {
        return Resource<DefaultDetailsDTO>(url: url, parameters: ["page": page])
    }
}
