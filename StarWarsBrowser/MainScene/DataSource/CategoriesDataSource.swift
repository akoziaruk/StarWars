//
//  CategoriesDataSource.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 6/24/21.
//

import UIKit

class CategoriesDataSource {
    enum Section {
      case main
    }
    
    // Diffable datasource
    typealias CategoryDataSource = UICollectionViewDiffableDataSource<Section,CategoryViewModel>
    typealias CategorySnapshot = NSDiffableDataSourceSnapshot<Section, CategoryViewModel>

    weak var collectionView: UICollectionView!
    lazy var dataSource = setupDataSource()
    
    init(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    func setupDataSource() -> CategoryDataSource {
      let dataSource = CategoryDataSource(
        collectionView: collectionView,
        cellProvider: { (collectionView, indexPath, viewModel) ->
          UICollectionViewCell? in
          let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "StarInfoCollectionViewCell",
            for: indexPath) as? CategoryCollectionViewCell
            cell?.updateWith(viewModel)
          return cell
      })
      return dataSource
    }
        
    func updateWith(_ categories: [CategoryViewModel]) {
        var snapshot = CategorySnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(categories)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
}
