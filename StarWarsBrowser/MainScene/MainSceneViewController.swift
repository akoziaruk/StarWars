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
    @IBOutlet weak var detailsCollectionView: UICollectionView!
        
    // Data source
    private var categoriesDataSource: CategoriesDataSource!
    private var detailsDataSource: DetailsDataSource!
          
    // View model
    private var viewModel = MainSceneViewModel()

    // Combine
    private var subscriptions = Set<AnyCancellable>()
    private var loadCategoriesSubject = PassthroughSubject<Void,Never>()
    private var loadDetailsSubject = PassthroughSubject<Int,Never>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDataSource()
        setupBindings()
        loadCategoriesSubject.send()
    }

    private func setupDataSource() {
        categoriesDataSource = CategoriesDataSource(categoriesCollectionView)
        detailsDataSource = DetailsDataSource(detailsCollectionView)
    }
    
    private func setupBindings() {
        viewModel.attachViewEventListener(loadCategoriesData: loadCategoriesSubject.eraseToAnyPublisher())
        viewModel.reloadCategories
            .sink{ [weak self] categories in
                self?.categoriesDataSource.updateWith(categories)
                self?.loadDetailsSubject.send(0)
            }
            .store(in: &subscriptions)
        
        viewModel.attachViewEventListener(loadDetailsData: loadDetailsSubject.eraseToAnyPublisher())
        viewModel.reloadDetails
            .sink{ [weak self] details in
                self?.detailsDataSource.updateWith(details)
            }
            .store(in: &subscriptions)
    }
}

// Details Collection View Delegate
extension MainSceneViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.size.width,
                      height: view.bounds.size.height - categoriesCollectionView.bounds.size.height)
    }
}
