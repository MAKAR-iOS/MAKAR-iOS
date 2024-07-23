//
//  LoginViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class LoginViewController: BaseViewController {
    
    // MARK: UI Components
    private let loginView = LoginView()

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        router.viewController = self
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        view.addSubview(loginView)

        loginView.tapLoginButton = {[weak self] in
            guard let self else { return }
            postAppleLogin()
            router.presentTabBarViewController()
        }

        loginView.tapSignUpButton = {[weak self] in
            guard let self else { return }
            postKakaoLogin()
            router.presentTabBarViewController()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        loginView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: Networking
    private func postAppleLogin() {
        print("postAppleLogin called")
    }

    private func postKakaoLogin() {
        print("postKakaoLogin called")
    }
}
