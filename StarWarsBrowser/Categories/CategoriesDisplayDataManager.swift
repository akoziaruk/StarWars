//
//  CategoriesDisplayDataManager.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 6/24/21.
//

import UIKit

protocol CategoriesDisplayDataManagerDelegate: NSObjectProtocol {
    func didSelectedCategory(with item: SelectedItem)
}

private typealias CategoryDataSource = UICollectionViewDiffableDataSource<Section,CategoryViewModel>
private typealias CategorySnapshot = NSDiffableDataSourceSnapshot<Section, CategoryViewModel>
private enum Section {
  case main
}

class CategoriesDisplayDataManager: NSObject {

    private weak var collectionView: UICollectionView!
    private weak var delegate: CategoriesDisplayDataManagerDelegate?
    private lazy var dataSource = setupDataSource()
    
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
    
    private func setupDataSource() -> CategoryDataSource {
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
        
    public func update(with categories: [CategoryViewModel]) {
        var snapshot = CategorySnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(categories)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func updateSelection(with index: Int) {
        var snapshot = dataSource.snapshot()
        let old = snapshot.selectedItem
        let new = snapshot.itemIdentifiers[index]
        old.isSelected = false
        new.isSelected = true
        snapshot.reloadItems([old, new])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension CategoriesDisplayDataManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateSelection(with: indexPath.row)
        let snapshot = dataSource.snapshot()
        let item = snapshot.itemIdentifiers[indexPath.row]
        delegate?.didSelectedCategory(with: SelectedItem(type: item.type, url: item.url))
    }
}

private extension CategorySnapshot {
    var selectedItem: CategoryViewModel {
        return itemIdentifiers.filter({ $0.isSelected }).first!
    }
}
