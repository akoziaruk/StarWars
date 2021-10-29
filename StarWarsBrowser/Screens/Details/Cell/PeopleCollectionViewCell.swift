//
//  PeopleCollectionViewCell.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/21/21.
//

import UIKit
import Combine

class PeopleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    private var cancellable: AnyCancellable?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateWith(_ viewModel: PeopleViewModel) {
        nameLabel.text = viewModel.name
//        cancellable = viewModel.image.sink { [unowned self] image in self.showImage(image: image) }
        
        // TODO: Add default image or loader
        imageView.image = nil
    }

    private func showImage(image: UIImage?) {
        //TODO: Stop loader
        imageView.image = image
    }
}
