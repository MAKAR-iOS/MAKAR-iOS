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
            guard let id = signInView.id,
                  let password = signInView.password
            else {
                presentSignInErrAlert()
                return
            }
            postSignIn(id: id, password: password)
        }

        signInView.tapSignUpButton = {[weak self] in
            guard let self else { return }
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
    private func postSignIn(id: String, password: String) {
        print("🚇 postSignIn called")
        NetworkService.shared.auth.postSignIn(
            id: id,
            password: password
        ) { result in
            switch result {
            case .success(let response):
                guard let data = response as? AuthResponse else { return }
                print("🎯 postSignIn success: " + "\(data)")
                UserDefaultHandler.accessToken = data.data.accessToken.token
                UserDefaultHandler.refreshToken = data.data.refreshToken.token
                self.router.presentTabBarViewController()
            case .requestErr(let errorResponse):
                dump(errorResponse)
                guard let data = errorResponse as? ErrorResponse else { return }
                print(data)
                self.presentSignInErrAlert()
            case .serverErr:
                print("serverErr")
                self.presentSignInErrAlert()
            case .networkFail:
                print("networkFail")
                self.presentSignInErrAlert()
            case .pathErr:
                print("pathErr")
                self.presentSignInErrAlert()
            }
        }
    }

    private func presentSignInErrAlert() {
        presentAlert(
            title: "로그인 실패",
            message: "로그인 할 수 없습니다.",
            cancelButton: "확인",
            style: .default,
            handler: nil
        )
    }
}
