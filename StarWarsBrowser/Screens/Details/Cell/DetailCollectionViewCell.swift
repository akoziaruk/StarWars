//
//  DetailCollectionViewCell.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/21/21.
//

import UIKit
import Combine

class DetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    private var cancellable: AnyCancellable?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancelImageLoading()
    }
    
    func updateWith(_ viewModel: PeopleViewModel) {
        cancelImageLoading()
        nameLabel.text = viewModel.name
        cancellable = viewModel.image.sink(receiveValue: { image in
            self.showImage(image: image)
        })
    }
    
    private func showImage(image: UIImage?) {
        //TODO: Stop loader
        cancelImageLoading()
        imageView.image = image
    }
    
    private func cancelImageLoading() {
        imageView.image = nil
        cancellable?.cancel()
    }
}
