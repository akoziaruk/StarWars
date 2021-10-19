//
//  UIViewController+extentions.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/8/21.
//

import UIKit

extension UIViewController {
    func add(viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    func presentErrorWith(message: String) {
        let alertController = AlertController.createWith(title: "Error",
                                                         message: message,
                                                         closeButtonTitle: "Ok")
        self.present(alertController, animated: true)
    }
}
