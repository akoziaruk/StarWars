//
//  CollectionViewHorizontalFlowLayout.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 29.04.2022.
//

import UIKit

class StarsInfiniteViewFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        
        scrollDirection = .horizontal
        minimumLineSpacing = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
