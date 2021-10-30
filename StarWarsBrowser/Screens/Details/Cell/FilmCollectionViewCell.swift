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

    override func prepareForReuse() {
        super.prepareForReuse()
        cancelImageLoading()
    }
    
    func updateWith(_ viewModel: FilmViewModel) {
        cancelImageLoading()
        titleLabel.text = viewModel.title
        directorLabel.text = viewModel.director
        descriptionLabel.text = viewModel.openingCrawl
                
        cancellable = viewModel.image.sink(receiveValue: { image in
            self.showImage(image: image)
        })
    }
    
    private func showImage(image: UIImage?) {
        //TODO: Stop loader
        cancelImageLoading()
        imageView.image = image
        print("SET IMAGE")
    }
    
    private func cancelImageLoading() {
        imageView.image = nil
        cancellable?.cancel()
    }

}
