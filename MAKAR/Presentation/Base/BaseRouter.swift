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
    func presentTabBarViewController() {
        let tabBarViewController = TabBarViewController()
        viewController?.navigationController?.pushViewController(tabBarViewController, animated: true)

        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.changeRootViewToTabBarViewController()
    }
}
