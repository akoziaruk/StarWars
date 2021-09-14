//
//  MainViewController.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import UIKit

class MainViewController: UIViewController {
    
    let categoriesViewController: CategoriesViewController!
    let detailsViewController: DetailsViewController!

    init(_ categoriesViewController: CategoriesViewController,
         _ detailsViewController: DetailsViewController) {
        self.categoriesViewController = categoriesViewController
        self.detailsViewController = detailsViewController
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        add(viewController: categoriesViewController)
        add(viewController: detailsViewController)

        addConstraints()
    }
    
    private func addConstraints() {
        categoriesViewController.view.translatesAutoresizingMaskIntoConstraints = false
        detailsViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            categoriesViewController.view.heightAnchor.constraint(equalToConstant: 200),
            categoriesViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            categoriesViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            categoriesViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor),

            detailsViewController.view.topAnchor.constraint(equalTo: categoriesViewController.view.bottomAnchor),
            detailsViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailsViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            detailsViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        
        view.backgroundColor = .purple
    }
    
}

fileprivate extension MainViewController {
    func add(viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
}
