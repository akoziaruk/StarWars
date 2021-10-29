//
//  ImageLoaderServiceType.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/29/21.
//

import Foundation
import Combine
import UIKit

protocol ImageLoaderServiceType: AnyObject {
    func loadImage(for path: String) -> AnyPublisher<UIImage?, Never>
}
