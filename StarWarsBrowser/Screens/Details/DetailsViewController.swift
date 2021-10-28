//
//  DetailsViewController.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/14/21.
//

import UIKit
import Combine

protocol DetailsViewControllerDelegate: NSObjectProtocol {
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}

class DetailsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private var viewModel: DetailsViewModelType!
    private let load = PassthroughSubject<Void, Never>()
    private var subscriptions: [AnyCancellable] = []
    private lazy var dataManager = { DetailsDisplayDataManager(collectionView) }()
    public weak var delegate: DetailsViewControllerDelegate?
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateWith(_ viewModel: DetailsViewModelType) {
        self.viewModel = viewModel
        bind(to: viewModel)
        load.send()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        updateWith(viewModel)
    }
    
    private func bind(to: DetailsViewModelType) {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
        
        let input = DetailsViewModelInput(load: load.eraseToAnyPublisher())
        let output = viewModel.transform(input: input)
        
        output.sink { [unowned self] in
            self.render(state: $0)
        }.store(in: &subscriptions)
    }
    
    private func render(state: DetailsLoadingState) {
        switch state {
        case .idle:
            break  // Started loading
        case .loading:
            break  // TODO: Show loader
        case .success(let details):
            dataManager.update(with: details)
        case .failure(_):
            break
        case .noResult:
            break
        }
    }
    
}

extension DetailsViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll(scrollView)
    }
}
