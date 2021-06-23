//
//  ViewModelBuilder.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 23.06.2021.
//

import Foundation

struct ViewModelBuilder {
    
    static func viewModel(from detail: DetailType?) -> DetailViewModelType? {
        switch detail {
        case let film as Film:
            return FilmViewModel(name: film.title)
        default:
            return nil
        }
    }
}
