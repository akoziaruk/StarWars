//
//  PeopleCollectionViewCell.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/21/21.
//

import UIKit

class PeopleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    //    @IBOutlet weak var heightLabel: UILabel!
//    @IBOutlet weak var hairColorLabel: UILabel!
//    @IBOutlet weak var eyeColorLabel: UILabel!
//    @IBOutlet weak var birthYearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateWith(_ viewModel: PeopleViewModel) {
        nameLabel.text = viewModel.name
        imageView.image = viewModel.image
//        heightLabel.text = viewModel.height
//        hairColorLabel.text = viewModel.hairColor
//        eyeColorLabel.text = viewModel.eyeColor
//        birthYearLabel.text = viewModel.birthYear
    }

}
