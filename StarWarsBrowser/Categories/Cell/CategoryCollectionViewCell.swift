//
//  CategoryCollectionViewCell.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/15/21.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    func updateWith(_ viewModel: CategoryViewModel) {
        titleLabel.text = viewModel.name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

