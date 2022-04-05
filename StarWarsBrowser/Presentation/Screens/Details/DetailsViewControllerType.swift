//
//  DetailsViewControllerType.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 26.01.2022.
//

import UIKit

protocol DetailsViewControllerType: UIViewController {
    var delegate: DetailsViewControllerDelegate? { get set }
    func updateWith(_ viewModel: DetailsViewModelType)
}

protocol DetailsViewControllerDelegate: NSObjectProtocol {
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}
