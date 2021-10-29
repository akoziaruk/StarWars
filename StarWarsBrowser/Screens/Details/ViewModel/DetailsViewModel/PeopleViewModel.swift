//
//  PeopleViewModel.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/21/21.
//

import Foundation
import UIKit.UIImage
import Combine

class PeopleViewModel: DetailViewModel {
    let name: String!
    
    init(name: String, image: AnyPublisher<UIImage?, Never>) {
        self.name = name
        
        super.init(image: image)
    }
}
