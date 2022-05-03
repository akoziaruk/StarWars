//
//  DetailsViewController.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/14/21.
//

import UIKit
import Combine

class DetailsViewController: UIViewController, DetailsViewControllerType {
    private var viewModel: DetailsViewModelType!
    private let loadNextPage = PassthroughSubject<Void, Never>()
    private var subscriptions: [AnyCancellable] = []
    private lazy var dataManager = { DetailsDisplayDataManager(collectionView) }()
    
    public weak var delegate: DetailsViewControllerDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var lastOffset = 0.0

    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateWith(_ viewModel: DetailsViewModelType) {
        self.viewModel = viewModel
        
        lastOffset = 0
        dataManager.prepareForReuse()
        bind(to: viewModel)
        loadNextPage.send()
    }
    
    public func loadNextPageData() {
        loadNextPage.send()
    }
    
    private func bind(to: DetailsViewModelType) {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
        
        let input = DetailsViewModelInput(loadNextPage: loadNextPage.eraseToAnyPublisher())
        let output = viewModel.transform(input: input)
        
        output.sink { [unowned self] in
            self.render(state: $0)
        }.store(in: &subscriptions)
    }
    
    private func render(state: DetailsLoadingState) {
        switch state {
        case .idle, .loading:
            activityIndicator.startAnimating()
            
        case .success(let details):
            activityIndicator.stopAnimating()
            dataManager.append(new: details)
            
        case .failure(_):
            activityIndicator.stopAnimating()
            
        case .noResult:
            activityIndicator.stopAnimating()
            
        }
    }
    
}

extension DetailsViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.didScroll(with: scrollView.contentOffset.x - lastOffset)
        lastOffset = scrollView.contentOffset.x
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // if last cell load next page
        let numberOfItems = collectionView.numberOfItems(inSection: indexPath.section)
        if indexPath.row + 1 >= numberOfItems {
            loadNextPageData()
        }
    }
}
