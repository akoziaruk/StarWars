//
//  DetailsDisplayDataManager.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/15/21.
//

import UIKit

class DetailsDisplayDataManager: NSObject {
    enum Section {
      case main
    }

    // Diffable datasource
    typealias DetailsDiffableDataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>
    typealias DetailsDiffableSnapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>

    private weak var collectionView: UICollectionView!
    private lazy var dataSource = setupDataSource()
    
    init(_ collectionView: UICollectionView) {
        super.init()
        
        self.collectionView = collectionView
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let nibName = UINib(nibName: "FilmCollectionViewCell", bundle:nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: "filmCell")

        let nib2Name = UINib(nibName: "PeopleCollectionViewCell", bundle:nil)
        collectionView.register(nib2Name, forCellWithReuseIdentifier: "peopleCell")
    }

    private func setupDataSource() -> DetailsDiffableDataSource {
      let dataSource = DetailsDiffableDataSource(
        collectionView: collectionView,
        cellProvider: { (collectionView, indexPath, viewModel) -> UICollectionViewCell? in
            switch viewModel {
            case let viewModel as FilmViewModel:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmCell",
                                                              for: indexPath) as? FilmCollectionViewCell
                cell?.updateWith(viewModel)
                return cell
                
            case let viewModel as PeopleViewModel:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "peopleCell",
                                                              for: indexPath) as? PeopleCollectionViewCell
                cell?.updateWith(viewModel)
                return cell
    
            default:
                fatalError()
            }
        })
      return dataSource
    }

    public func update(with details: [DetailViewModelType]) {
        var snapshot = DetailsDiffableSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(details as! [AnyHashable])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
