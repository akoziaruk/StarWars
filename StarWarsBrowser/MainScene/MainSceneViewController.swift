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
                self?.updateWith(categories)
                self?.loadInfoSubject.send(0)
            }
            .store(in: &subscriptions)
        
        viewModel.attachViewEventListener(loadInfoData: loadInfoSubject.eraseToAnyPublisher())
        viewModel.reloadDetails
            .sink{ [weak self] details in
                self?.updateWith(details)
            }
            .store(in: &subscriptions)
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
    
    //MARK: Updating with data
    
    private func updateWith(_ categories: [Category]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(categories)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
        
    private func updateWith(_ details: [DetailViewModelType]) {
        switch details.first {
        case is FilmViewModel:
            updateWith(films: details as! [FilmViewModel])
        default:
            break
        }
    }
    
    private func updateWith(films: [FilmViewModel]) {
        
    }
}

