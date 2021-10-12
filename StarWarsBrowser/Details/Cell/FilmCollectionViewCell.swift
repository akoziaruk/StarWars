//
//  FilmCollectionViewCell.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/15/21.
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