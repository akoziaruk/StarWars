//
//  DetailsViewController.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import Combine
import UIKit

class DetailsViewController: UIViewController {
    
    private let viewModel: DetailsViewModelType!
    private let selection = PassthroughSubject<(DetailDataType, URL), Never>()

    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selection.send((.film, URL(fileURLWithPath: "")))
        // selection load type
    }
}
