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
        collectionView.register(nibName, forCellWithReuseIdentifier: Constants.ReuseCellIdentifier.film)

        let nib2Name = UINib(nibName: "DetailCollectionViewCell", bundle:nil)
        collectionView.register(nib2Name, forCellWithReuseIdentifier: Constants.ReuseCellIdentifier.detail)
    }

    private func setupDataSource() -> DetailsDiffableDataSource {
      let dataSource = DetailsDiffableDataSource(
        collectionView: collectionView,
        cellProvider: { (collectionView, indexPath, viewModel) -> UICollectionViewCell? in
            switch viewModel {
            case let viewModel as FilmViewModel:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReuseCellIdentifier.film,
                                                              for: indexPath) as? FilmCollectionViewCell
                cell?.updateWith(viewModel)
                return cell
                
            case let viewModel as DetailViewModel:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReuseCellIdentifier.detail,
                                                              for: indexPath) as? DetailCollectionViewCell
                cell?.updateWith(viewModel)
                return cell
    
            default:
                fatalError()
            }
        })
      return dataSource
    }

    public func append(new details: [AnyHashable]) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(details)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    public func prepareForReuse() {
        var snapshot = DetailsDiffableSnapshot()
        snapshot.appendSections([.main])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    struct Constants {
        struct ReuseCellIdentifier {
            static let film = "filmCell"
            static let detail = "detailCell"
        }
    }
}
