//
//  MainViewController.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import UIKit

class MainViewController: UIViewController {
    var categoriesViewController: CategoriesViewControllerType!
    var detailsViewController: DetailsViewControllerType!
    
    @IBOutlet weak var paralaxView: StarsParalaxView!
    @IBOutlet weak var logoView: UIView!

    init(_ categoriesViewController: CategoriesViewControllerType,
         _ detailsViewController: DetailsViewControllerType) {
        self.categoriesViewController = categoriesViewController
        self.detailsViewController = detailsViewController
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        add(viewController: categoriesViewController)
        add(viewController: detailsViewController)
        addConstraints()
        detailsViewController.delegate = self
    }
    
    
    private func addConstraints() {
        categoriesViewController.view.translatesAutoresizingMaskIntoConstraints = false
        detailsViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            categoriesViewController.view.heightAnchor.constraint(equalToConstant: 130),
            categoriesViewController.view.topAnchor.constraint(equalTo: logoView.bottomAnchor),
            categoriesViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            categoriesViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            detailsViewController.view.topAnchor.constraint(equalTo: categoriesViewController.view.bottomAnchor),
            detailsViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailsViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            detailsViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
}

extension MainViewController: DetailsViewControllerDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        paralaxView.doParalax(with: scrollView.contentOffset.x)
    }
}
