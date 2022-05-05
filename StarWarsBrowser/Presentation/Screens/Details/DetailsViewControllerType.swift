//
//  DetailsViewControllerType.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 26.01.2022.
//

import UIKit

protocol DetailsViewControllerType: UIViewController {
    var delegate: DetailsViewControllerDelegate? { get set }
}

protocol DetailsViewControllerDelegate: NSObjectProtocol {
    func didScroll(with offset: CGFloat)
}
