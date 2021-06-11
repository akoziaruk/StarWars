//
//  ViewController.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 25.05.2021.
//

import UIKit
import Combine

class MainSceneViewController: UICollectionViewController {
    private var subscriptions = Set<AnyCancellable>()

    enum Section {
      case main
    }
            
    // Diffable datasource
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Person>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Person>

        
    private var viewModel = MainSceneViewModel()
    
    private var loadDataSubject = PassthroughSubject<Void,Never>()

    private lazy var dataSource = makeDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        loadDataSubject.send()
    }

    func setupBindings() {
        viewModel.attachViewEventListener(loadData: loadDataSubject.eraseToAnyPublisher())
        viewModel.reloadPeopeList
            .sink{ [weak self] people in
                self?.updateWith(people, animated: true)
            }
            .store(in: &subscriptions)
    }
    
    func updateWith(_ people: [Person], animated: Bool) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(people)
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
    
    func makeDataSource() -> DataSource {
      let dataSource = DataSource(
        collectionView: collectionView,
        cellProvider: { (collectionView, indexPath, person) ->
          UICollectionViewCell? in
          let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "StarInfoCollectionViewCell",
            for: indexPath) as? StarWarsInfoCollectionViewCell
            cell?.titleLabel.text = person.name
            cell?.backgroundColor = .gray
          return cell
      })
      return dataSource
    }
    
}

