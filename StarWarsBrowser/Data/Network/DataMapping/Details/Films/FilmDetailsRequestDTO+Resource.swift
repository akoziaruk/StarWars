//
//  FilmDetailsRequestDTO.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 22.04.2022.
//

import Foundation

struct FilmDetailsRequestDTO {
    let url: URL
    let page: Int
}

extension FilmDetailsRequestDTO {
    var resource: Resource<FilmDetailsDTO> {
        return Resource<FilmDetailsDTO>(url: url, parameters: ["page": page])
    }
}
