//
//  DetailViewModel.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import Foundation
import Combine
import UIKit.UIImage

class DetailViewModel: Hashable {
    var uuid = UUID()
    var image: AnyPublisher<UIImage?, Never>
    
    init(image: AnyPublisher<UIImage?, Never>) {
        self.image = image
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    static func == (lhs: DetailViewModel, rhs: DetailViewModel) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}


