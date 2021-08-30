//
//  Alert.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/7/21.
//

import UIKit

struct AlertController {
    
    static fileprivate func createWith(title: String,
                                       message: String,
                                       closeButtonTitle: String) -> UIAlertController {
        let controller = UIAlertController(title: title,
                                           message: message,
                                           preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: closeButtonTitle, style: .cancel, handler: nil))
        return controller
    }
    
}


extension UIViewController {
    func presentErrorWith(message: String) {
        let alertController = AlertController.createWith(title: "Error",
                                                         message: message,
                                                         closeButtonTitle: "Ok")
        self.present(alertController, animated: true)
    }
}


