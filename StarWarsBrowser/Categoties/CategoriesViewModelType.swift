//
//  CategoriesViewModelType.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/30/21.
//

import Combine

struct CategoriesViewModelInput {
    let load: AnyPublisher<Void, Never>
}

enum CategoriesLoadingState {
    case idle
    case loading
    case success([CategoryViewModel])
    case failure(Error)
    case noResult
}

extension CategoriesLoadingState: Equatable {
    static func == (lhs: CategoriesLoadingState, rhs: CategoriesLoadingState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle): return true
        case (.loading, .loading): return true
        case (.success(let lhsMovies), .success(let rhsMovies)): return lhsMovies == rhsMovies
        case (.noResult, .noResult): return true
        case (.failure, .failure): return true
        default: return false
        }
    }
}

typealias CategoriesViewModelOutput = AnyPublisher<CategoriesLoadingState, Never>

protocol CategoriesViewModelType {
    func transform(input: CategoriesViewModelInput) -> CategoriesViewModelOutput
}

