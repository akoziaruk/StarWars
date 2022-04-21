//
//  PersistentFilmDetail+Mapping.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 11.04.2022.
//

import Foundation
import CoreData

extension Array where Element == PersistentFilmDetail {
    func toDTO() -> FilmDetailsDTO {
        return FilmDetailsDTO(details: self)
    }
}

extension FilmDetailsDTO {
    func toDomain() -> [Film] {
        return results.map {
            Film(name: $0.name, openingCrawl: $0.openingCrawl, director: $0.director)
        }
    }
    
    init(details: [PersistentFilmDetail]) {
        results = details.map { FilmDetailsDTO.FilmDTO(film: $0) }
    }
}

extension FilmDetailsDTO.FilmDTO {
    init(film: PersistentFilmDetail) {
        name = film.name
        openingCrawl = film.openingCrawl
        director = film.director
        releaseDate = film.releaseDate
    }
    
    func toEntity(in context: NSManagedObjectContext, requestDTO: FilmDetailsRequestDTO) -> PersistentFilmDetail {
        let detail = PersistentFilmDetail(context: context)
        detail.name = name
        detail.openingCrawl = openingCrawl
        detail.director = director
        detail.releaseDate = releaseDate
        detail.page = Int32(requestDTO.page)
        return detail
    }
}
