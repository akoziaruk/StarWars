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
    func loadDetails(url: URL, page: Int, category: Category.T) -> AnyPublisher<Result<[Detailable], Error>, Never>
    func loadImage(for detail: Detailable) -> AnyPublisher<UIImage?, Never>
}
