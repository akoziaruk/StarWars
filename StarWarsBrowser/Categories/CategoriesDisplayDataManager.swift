//
//  CategoriesDisplayDataManager.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 6/24/21.
//

import UIKit

class CategoriesDisplayDataManager: NSObject {
    enum Section {
      case main
    }
    
    // Diffable datasource
    typealias CategoryDataSource = UICollectionViewDiffableDataSource<Section,CategoryViewModel>
    typealias CategorySnapshot = NSDiffableDataSourceSnapshot<Section, CategoryViewModel>

    weak var collectionView: UICollectionView!
    weak var delegate: CategoriesDisplayDataManagerDelegate?
    lazy var dataSource = setupDataSource()
    
    init(_ collectionView: UICollectionView, delegate: CategoriesDisplayDataManagerDelegate) {
        super.init()
        
        self.collectionView = collectionView
        self.delegate = delegate
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self

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

extension CategoriesDisplayDataManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let snapshot = dataSource.snapshot()
        let item = snapshot.itemIdentifiers[indexPath.row]
        delegate?.didSelectedCategory(for: item.urlString)
    }
}

protocol CategoriesDisplayDataManagerDelegate: NSObjectProtocol {
    func didSelectedCategory(for urlString: String)
}
