//
//  BaseRouter.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

final class BaseRouter {

    // MARK: Properties
    weak var viewController: UIViewController?
    
    // MARK: Routing
    func presentHomeViewController() {
        let homeViewController = HomeViewController()
        viewController?.present(homeViewController, animated: true)

        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.changeRootViewToHomeViewController()
    }
}
