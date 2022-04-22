//
//  DefaultDetailsRequestDTO.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 22.04.2022.
//

import Foundation

struct DefaultDetailsRequestDTO {
    let url: URL
    let page: Int
}

extension DefaultDetailsRequestDTO {
    var resource: Resource<DefaultDetailsDTO> {
        return Resource<DefaultDetailsDTO>(url: url, parameters: ["page": page])
    }
}
