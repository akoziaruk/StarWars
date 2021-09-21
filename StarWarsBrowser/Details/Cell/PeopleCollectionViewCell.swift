//
//  PeopleCollectionViewCell.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/21/21.
//

import UIKit

class PeopleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateWith(_ viewModel: PeopleViewModel) {
        nameLabel.text = viewModel.name
    }

}
