//
//  CategoryCollectionViewCell.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 09.06.2021.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    func updateWith(_ viewModel: CategoryViewModel) {
        titleLabel.text = viewModel.name
    }
}
