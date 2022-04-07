//
//  MainUseCaseType.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/31/21.
//

import Combine
import Foundation
import UIKit

protocol DetailsUseCaseType {
    func fetchDetails(url: URL, page: Int, category: Category.T) -> AnyPublisher<Result<[Detailable], Error>, Never>
    func fetchImage(for detail: Detailable) -> AnyPublisher<UIImage?, Never>
}
