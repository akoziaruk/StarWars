//
//  DetailImagesRepositoryType.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 22.04.2022.
//

import Foundation
import UIKit
import Combine

protocol DetailImagesRepositoryType {
    func loadImage(for detail: Detailable, category: Category.T) -> AnyPublisher<UIImage?, Never>
}
