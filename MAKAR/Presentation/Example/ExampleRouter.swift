//
//  ExampleRouter.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/20.
//

import UIKit

final class ExampleRouter {
    // MARK: Properties
    weak var viewController: UIViewController?
    
    // MARK: Routing
    func presentSomeViewController() {
        let someViewController = UIViewController()
        someViewController.view.backgroundColor = .white
        viewController?.present(someViewController, animated: true)
    }
}
