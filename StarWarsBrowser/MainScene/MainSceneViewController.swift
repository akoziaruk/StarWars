//
//  ViewController.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 25.05.2021.
//

import UIKit
import Combine
//
//class MainSceneViewController: UIViewController {
//    @IBOutlet weak var categoriesCollectionView: UICollectionView!
//    @IBOutlet weak var detailsCollectionView: UICollectionView!
//        
//    // Data source
//    private var categoriesDataSource: CategoriesDataSource!
//    private var detailsDataSource: DetailsDataSource!
//          
//    // View model
////    private let viewModel: FilmsViewModelType
//
//    // Combine
//    private var subscriptions = Set<AnyCancellable>()
//    private var appear = PassthroughSubject<Void,Never>()
//    
//    private var loadDetailsSubject = PassthroughSubject<Int,Never>()
//    
//    init(viewModel: FilmsViewModelType) {
//        self.viewModel = viewModel
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("Not supported!")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupDataSource()
//        setupBindings()
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        appear.send()
//    }
//
//    private func setupDataSource() {
//        categoriesDataSource = CategoriesDataSource(categoriesCollectionView)
////        detailsDataSource = DetailsDataSource(detailsCollectionView)
//    }
//    
//    private func setupBindings() {
//        
//        let input = FilmsViewModelInput(appear: appear.eraseToAnyPublisher())
//        let output = viewModel.transform(input: input)
//
//        output.sink(receiveValue: {[unowned self] state in
//            self.show(state)
//        })
//        .store(in: &subscriptions)
//        
////        viewModel.attachViewEventListener(loadCategoriesData: loadCategoriesSubject.eraseToAnyPublisher())
////        viewModel.$categories
////            .filter{ $0.count > 0 }
////            .sink { state in
////                //TODO: Implement Error handling
////            } receiveValue: { [weak self] categories in
////                self?.categoriesDataSource.updateWith(categories)
////                self?.loadDetailsSubject.send(0)
////            }
////            .store(in: &subscriptions)
////
////        viewModel.attachViewEventListener(loadDetailsData: loadDetailsSubject.eraseToAnyPublisher())
////        viewModel.$details
////            .sink{ [weak self] details in
////                self?.detailsDataSource.updateWith(details)
////            }
////            .store(in: &subscriptions)
//    }
//    
//    private func show(_ state: FilmsLoadingState) {
//        
//    }
//}
//
//// Details Collection View Delegate
//extension MainSceneViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.bounds.size.width,
//                      height: view.bounds.size.height - categoriesCollectionView.bounds.size.height)
//    }
//}
