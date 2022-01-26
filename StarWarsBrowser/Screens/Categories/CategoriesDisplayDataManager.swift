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
        collectionView.register(nibName, forCellWithReuseIdentifier: Constants.ReuseCellIdentifier.category)
    }
    
    private func setupDataSource() -> CategoryDataSource {
      let dataSource = CategoryDataSource(
        collectionView: collectionView,
        cellProvider: { (collectionView, indexPath, viewModel) ->
          UICollectionViewCell? in
          let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.ReuseCellIdentifier.category,
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
    
    private func updateSelectionWith(newIndex: Int, currentIndex: Int) {
        var snapshot = dataSource.snapshot()
        let current = snapshot.itemIdentifiers[currentIndex]
        let new = snapshot.itemIdentifiers[newIndex]
        current.isSelected = false
        new.isSelected = true
        snapshot.reloadItems([current, new])
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    struct Constants {
        struct ReuseCellIdentifier {
            static let category = "categoryCell"
        }
    }
}

extension CategoriesDisplayDataManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let snapshot = dataSource.snapshot()
        let currentIndex = snapshot.selectedItemIndex
        let newIndex = indexPath.row
        
        guard currentIndex != newIndex else { return }
        
        updateSelectionWith(newIndex: newIndex, currentIndex: currentIndex)
        
        let item = snapshot.itemIdentifiers[newIndex]
        delegate?.didSelectedCategory(with: SelectedItem(type: item.type, url: item.url))
    }
}

fileprivate extension CategorySnapshot {
    var selectedItemIndex: Int {
        return itemIdentifiers.firstIndex(where: { $0.isSelected })!
    }
}
