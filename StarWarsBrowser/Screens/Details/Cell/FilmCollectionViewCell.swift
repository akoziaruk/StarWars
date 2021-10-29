//
//  FilmCollectionViewCell.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/15/21.
//

import UIKit
import Combine

class FilmCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private var cancellable: AnyCancellable?

    func updateWith(_ viewModel: FilmViewModel) {
        titleLabel.text = viewModel.title
        directorLabel.text = viewModel.director
        descriptionLabel.text = viewModel.openingCrawl
        cancellable = viewModel.image.sink { [unowned self] image in self.showImage(image: image) }
        
        // TODO: Add default image or loader
        imageView.image = nil
    }
    
    private func showImage(image: UIImage?) {
        //TODO: Stop loader
        imageView.image = image
    }
}
