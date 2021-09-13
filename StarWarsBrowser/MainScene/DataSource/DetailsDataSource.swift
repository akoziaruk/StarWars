//
//  DetailsDataSource.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 6/24/21.
//

import UIKit
//
//class DetailsDataSource {
//    enum Section {
//      case main
//    }
//    
//    // Diffable datasource
//    typealias DetailsDiffableDataSource = UICollectionViewDiffableDataSource<Section, DetailsViewModel>
//    typealias DetailsDiffableSnapshot = NSDiffableDataSourceSnapshot<Section, DetailsViewModel>
//
//    weak var collectionView: UICollectionView!
//    lazy var dataSource = setupDataSource()
//    
//    init(_ collectionView: UICollectionView) {
//        self.collectionView = collectionView
//    }
//    
//    func setupDataSource() -> DetailsDiffableDataSource {
//      let dataSource = DetailsDiffableDataSource(
//        collectionView: collectionView,
//        cellProvider: { (collectionView, indexPath, viewModel) ->
//          UICollectionViewCell? in
//            
//            // TODO: Add other DetailsViewModels
//            if let viewModel = viewModel as? FilmViewModel {
//                let cell = collectionView.dequeueReusableCell(
//                  withReuseIdentifier: "FilmCollectionViewCell",
//                  for: indexPath) as? FilmCollectionViewCell
//                cell?.updateWith(viewModel)
//                return cell
//            }
//            
//          return nil
//      })
//      return dataSource
//    }
//
//    func updateWith(_ details: [DetailsViewModel]) {
//        var snapshot = DetailsDiffableSnapshot()
//        snapshot.appendSections([.main])
//        snapshot.appendItems(details)
//        dataSource.apply(snapshot, animatingDifferences: true)
//    }
//}
