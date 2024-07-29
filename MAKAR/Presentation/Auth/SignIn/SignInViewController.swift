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

    private let dismissButton = BaseButton().then {
        $0.setImage(MakarButton.deleteButton, for: .normal)
    }

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
            postSignIn()
        }

        signInView.tapSignUpButton = {[weak self] in
            guard let self else { return }
            // TODO: transition
            router.presentSignUpViewController()
        }

        dismissButton.tap = { [weak self] in
            guard let self else {
                return }
            router.popViewController()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        signInView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: Set Navigation
    override func setNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: dismissButton)
        navigationItem.hidesBackButton = true
    }
}

extension SignInViewController {
    // MARK: Network
    // TODO: SignIn
    private func postSignIn() {
        // if success
        router.presentTabBarViewController()
        // else
//        presentAlert(
//            title: "로그인 실패",
//            message: "로그인 할 수 없습니다.",
//            cancelButton: "확인",
//            style: .default,
//            handler: nil
//        )
    }
}
