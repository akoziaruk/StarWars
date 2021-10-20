//
//  Resource+DetailsType.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import Foundation

extension Resource {
    static func films(with url: URL) -> Resource<FilmCollection> {
        return Resource<FilmCollection>(url: url)
    }
    static func people(with url: URL) -> Resource<PeopleCollection> {
        return Resource<PeopleCollection>(url: url)
    }
    static func platents(with url: URL) -> Resource<PlanetCollection> {
        return Resource<PlanetCollection>(url: url)
    }
}
