//
//  InfoCollectionViewCell.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 21.06.2021.
//

import UIKit

class FilmCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    func updateWith(_ viewModel: FilmViewModel) {
        titleLabel.text = viewModel.title
        directorLabel.text = viewModel.director
        descriptionTextView.text = viewModel.openingCrawl
    }
}
