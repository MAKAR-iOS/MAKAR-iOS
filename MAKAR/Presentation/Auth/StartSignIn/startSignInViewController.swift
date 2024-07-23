//
//  StartSignInViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class StartSignInViewController: BaseViewController {
    
    // MARK: UI Components
    private let startSignInView = StartSignInView()

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

        view.addSubview(startSignInView)

        startSignInView.tapSignInButton = {[weak self] in
            guard let self else { return }
            postAppleLogin()
            router.presentTabBarViewController()
        }

        startSignInView.tapSignUpButton = {[weak self] in
            guard let self else { return }
            postKakaoLogin()
            router.presentTabBarViewController()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        startSignInView.snp.makeConstraints {
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
