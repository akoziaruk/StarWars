//
//  DetailsViewController.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/14/21.
//

import UIKit
import Combine

private let reuseIdentifier = "Cell"

class DetailsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private let viewModel: DetailsViewModelType!
    private let selection = PassthroughSubject<(DetailDataType, URL), Never>()

    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        selection.send((.film, URL(fileURLWithPath: "")))

        collectionView.backgroundColor = .red
                
        // Do any additional setup after loading the view.
    }
    
}

//extension DetailsViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.bounds.size.width,
//                      height: view.bounds.size.height)
//    }
//}
