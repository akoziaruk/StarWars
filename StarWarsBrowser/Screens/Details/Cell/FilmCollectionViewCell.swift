//
//  FilmCollectionViewCell.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/15/21.
//

import UIKit

class FilmCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func updateWith(_ viewModel: FilmViewModel) {
        titleLabel.text = viewModel.title
        directorLabel.text = viewModel.director
        descriptionLabel.text = viewModel.openingCrawl
        imageView.image = viewModel.image
    }
}
