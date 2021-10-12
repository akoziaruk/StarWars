//
//  CategoryCollectionViewCell.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/15/21.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var logoImageView: CategoryImageView!
    @IBOutlet weak var gradientView: CategoryGradientView!
    
    func updateWith(_ viewModel: CategoryViewModel) {
        titleLabel.text = viewModel.name
        logoImageView.image = viewModel.image
        logoImageView.set(selected: viewModel.isSelected)
        gradientView.set(selected: viewModel.isSelected)
    }
}

