//
//  SignInViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 7/23/24.
//

import UIKit

class SignInViewController: BaseViewController {
    
    // MARK: UI Components
    private let signInView = SignInView()

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

        view.addSubview(signInView)

        signInView.tapSignInButton = {[weak self] in
            guard let self else { return }
            router.presentTabBarViewController()
        }

        signInView.tapSignUpButton = {[weak self] in
            guard let self else { return }
            // TODO: transition
            router.presentSignUpViewController()
        }

        signInView.tapDismissButton = { [weak self] in
            guard let self else { return }
            router.dismissViewController()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        signInView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
