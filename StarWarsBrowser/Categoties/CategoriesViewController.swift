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
    private var subscriptions: [AnyCancellable] = []
    private let load = PassthroughSubject<Void, Never>()

    init(viewModel: CategoriesViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind(to: viewModel)
    }
    
    private func configureUI() {
        view.backgroundColor = .yellow
    }
    
    private func bind(to: CategoriesViewModelType) {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
        let input = CategoriesViewModelInput(load: load.eraseToAnyPublisher())
        let output = viewModel.transform(input: input)
        
        output.sink { [unowned self] in
            self.render(state: $0)
        }.store(in: &subscriptions)
    }
    
    private func render(state: CategoriesLoadingState) {
        switch state {
        case .idle: break
           // App just started loading
        default:
            break
        }
        //TODO
        
        /*
         case loading
         case success([CategoryViewModel])
         case failure(Error)
         case noResult
         */
    }
}
