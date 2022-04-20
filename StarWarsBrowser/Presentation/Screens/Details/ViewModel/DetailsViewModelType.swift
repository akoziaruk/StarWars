//
//  DetailsViewModelType.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import Combine
import Foundation

struct DetailsViewModelInput {
    let loadNextPage: AnyPublisher<Void, Never>
}

enum DetailsLoadingState {
    case idle
    case loading
    case success([AnyHashable])
    case failure(Error)
    case noResult
}

extension DetailsLoadingState: Equatable {
    static func == (lhs: DetailsLoadingState, rhs: DetailsLoadingState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle): return true
        case (.loading, .loading): return true
        case (.success(let lhs), .success(let rhs)):
            let result = lhs == rhs
            print(result)
            return result
        case (.noResult, .noResult): return true
        case (.failure, .failure): return true
        default: return false
        }
    }
}

typealias DetailsViewModelOutput = AnyPublisher<DetailsLoadingState, Never>

protocol DetailsViewModelType {
    func transform(input: DetailsViewModelInput) -> DetailsViewModelOutput
}
