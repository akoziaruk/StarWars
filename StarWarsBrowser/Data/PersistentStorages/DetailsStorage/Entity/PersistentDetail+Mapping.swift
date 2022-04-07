//
//  PersistentDetail+Mapping.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 07.04.2022.
//

import Foundation

protocol DetailableDTO { }

extension Array where Element == PersistentDetail {
    func toDTO() -> DetailableDTO {
        DefaultDetailsDTO(details: self)
    }
}

extension DefaultDetailsDTO: DetailableDTO {
    init(details: [PersistentDetail]) {
        results = details.map { DefaultDetailsDTO.DetailDTO(detail: $0) }
    }
}

extension DefaultDetailsDTO.DetailDTO {
    init(detail: PersistentDetail) {
        name = detail.name
    }
}

extension FilmDetailsDTO: DetailableDTO {
    init(details: [PersistentDetail]) {
        results = details.map { FilmDetailsDTO.FilmDTO(film: $0) }
    }
}

extension FilmDetailsDTO.FilmDTO {
    init(film: PersistentDetail) {
        name = film.name
        openingCrawl = film.openingCrawl ?? ""
        director = film.director ?? ""
    }
}
