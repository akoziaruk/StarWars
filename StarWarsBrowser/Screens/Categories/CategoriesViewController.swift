//
//  CategoriesViewController.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/31/21.
//

import UIKit
import Combine

class CategoriesViewController: UIViewController {
    private let viewModel: CategoriesViewModelType
    private let load = PassthroughSubject<Void, Never>()
    private let select = PassthroughSubject<SelectedItem, Never>()
    private var subscriptions: [AnyCancellable] = []
    private lazy var dataManager = { CategoriesDisplayDataManager(collectionView,
                                                                  delegate: self) }()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    init(viewModel: CategoriesViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(to: viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        load.send()
    }

    private func bind(to: CategoriesViewModelType) {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
        
        let input = CategoriesViewModelInput(load: load.eraseToAnyPublisher(),
                                             select: select.eraseToAnyPublisher())
        let output = viewModel.transform(input: input)
        
        output.sink { [unowned self] in
            self.render(state: $0)
        }.store(in: &subscriptions)
    }
    
    private func render(state: CategoriesLoadingState) {
        switch state {
        case .idle:
            break  // App just started loading
        case .loading:
            break  // TODO: Show loader
        case .success(let categories):
            dataManager.update(with: categories)
        case .failure(_):
            presentErrorWith(message: Constants.loadingErrorTitle)
        case .noResult:
            break  // TODO: Show no result state
        }
    }
    
    struct Constants {
        static let loadingErrorTitle = "Failed to load data"
    }
}

extension CategoriesViewController: CategoriesDisplayDataManagerDelegate {
    func didSelectedCategory(with item: SelectedItem) {
        select.send(item)
    }
}
