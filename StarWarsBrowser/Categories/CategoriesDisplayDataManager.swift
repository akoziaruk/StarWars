//
//  CategoriesDisplayDataManager.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 6/24/21.
//

import UIKit

class CategoriesDisplayDataManager {
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
        setupCell()
    }
    
    private func setupCell() {
        let nibName = UINib(nibName: "CategoryCollectionViewCell", bundle:nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: "categoryCell")
    }
    
    func setupDataSource() -> CategoryDataSource {
      let dataSource = CategoryDataSource(
        collectionView: collectionView,
        cellProvider: { (collectionView, indexPath, viewModel) ->
          UICollectionViewCell? in
          let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "categoryCell",
            for: indexPath) as? CategoryCollectionViewCell
            cell?.updateWith(viewModel)
          return cell
      })
      return dataSource
    }
        
    func update(with categories: [CategoryViewModel]) {
        var snapshot = CategorySnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(categories)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
}
