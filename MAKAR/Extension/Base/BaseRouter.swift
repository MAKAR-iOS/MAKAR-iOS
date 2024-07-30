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
    func presentSignInViewController() {
        let signInViewController = SignInViewController()
        viewController?.navigationController?.pushViewController(signInViewController, animated: true)
    }

    func presentSignUpViewController() {
        let signUpViewController = SignUpViewController()
        viewController?.navigationController?.pushViewController(signUpViewController, animated: true)
    }

    func presentTabBarViewController() {
        let tabBarViewController = TabBarViewController()
        viewController?.navigationController?.pushViewController(tabBarViewController, animated: true)

        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.changeRootViewToTabBarViewController()
    }

    func popViewController() {
        viewController?.navigationController?.popViewController(animated: true)
    }

    func dismissViewController() {
        viewController?.dismiss(animated: true)
    }
}
