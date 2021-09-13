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
}
