//
//  ViewController.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 25.05.2021.
//

import UIKit
import Combine

class MainSceneViewController: UIViewController {
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var infoCollectionView: UICollectionView!
    
    // Diffable datasource
    typealias DataSource = UICollectionViewDiffableDataSource<Section,Category>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Category>
    
    private lazy var dataSource = makeDataSource()

    enum Section {
      case main
    }
          
    // View model
    private var viewModel = MainSceneViewModel()

    // Combine
    private var subscriptions = Set<AnyCancellable>()
    private var loadCategoriesSubject = PassthroughSubject<Void,Never>()
    private var loadInfoSubject = PassthroughSubject<Int,Never>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        loadCategoriesSubject.send()
    }

    private func setupBindings() {
        viewModel.attachViewEventListener(loadCategoriesData: loadCategoriesSubject.eraseToAnyPublisher())
        viewModel.reloadCategories
            .sink{ [weak self] categories in
                self?.updateWith(categories, animated: true)
                self?.loadInfoSubject.send(0)
            }
            .store(in: &subscriptions)
        
        viewModel.attachViewEventListener(loadInfoData: loadInfoSubject.eraseToAnyPublisher())
        viewModel.reloadDetails
            .sink{ [weak self] details in
                self?.updateWith(details, animated: true)
            }
            .store(in: &subscriptions)
    }
    
    private func updateWith(_ categories: [Category], animated: Bool) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(categories)
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
        
    private func updateWith(_ details: Details, animated: Bool) {
        
        // Cast and display?        
    }
    
    private func makeDataSource() -> DataSource {
      let dataSource = DataSource(
        collectionView: categoriesCollectionView,
        cellProvider: { (collectionView, indexPath, category) ->
          UICollectionViewCell? in
          let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "StarInfoCollectionViewCell",
            for: indexPath) as? CategoryCollectionViewCell
            cell?.titleLabel.text = category.name
            cell?.backgroundColor = .gray
          return cell
      })
      return dataSource
    }
    
}

