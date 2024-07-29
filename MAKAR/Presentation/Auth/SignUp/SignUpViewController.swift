//
//  SignUpViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 7/23/24.
//

import UIKit

class SignUpViewController: BaseViewController {
    
    // MARK: UI Components
    private let scrollView = UIScrollView().then {
        $0.delaysContentTouches = false
    }

    private let signUpView = SignUpView()

    private let backButton = BaseButton().then {
        $0.setImage(MakarButton.dismissButton, for: .normal)
    }

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewTransition()
        setNavigationItem()

        router.viewController = self
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        view.addSubview(scrollView)
        scrollView.addSubview(signUpView)

        signUpView.tapConfirmButton = { [weak self] in
            guard let self else { return }
            guard let id = signUpView.id,
                  let password = signUpView.password,
                  let email = signUpView.email,
                  let username = signUpView.username
            else {
                presentSignUpErrAlert()
                return
            }
            postSignUp(
                id: id,
                password: password,
                email: email,
                username: username
            )
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        signUpView.snp.makeConstraints {
            $0.top.bottom.equalTo(scrollView.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(scrollView.safeAreaLayoutGuide).inset(20)
        }
    }

    // MARK: View Transition
    override func viewTransition() {
        backButton.tap = { [weak self] in
            guard let self else { return }
            router.popViewController()
        }
    }

    // MARK: Set Navigation
    override func setNavigationItem() {
        navigationItem.title = "회원가입"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
}

extension SignUpViewController {
    // MARK: Network
    private func postSignUp(
        id: String,
        password: String,
        email: String,
        username: String
    ) {
        print("🚇 postSignUp called")
        NetworkService.shared.auth.postSignUp(
            id: id,
            password: password,
            email: email,
            username: username
        ) { result in
            switch result {
            case .success(let response):
                guard let data = response as? AuthResponse else { return }
                print("🎯 postSignIn success: " + "\(data)")
                self.presentSignUpAlert()
            case .requestErr(let errorResponse):
                dump(errorResponse)
                guard let data = errorResponse as? ErrorResponse else { return }
                print(data)
                self.presentSignUpErrAlert()
            case .serverErr:
                print("serverErr")
                self.presentSignUpErrAlert()
            case .networkFail:
                print("networkFail")
                self.presentSignUpErrAlert()
            case .pathErr:
                print("pathErr")
                self.presentSignUpErrAlert()
            }
        }
    }

    private func presentSignUpAlert() {
        presentAlert(
            title: "회원가입 실패",
            message: "잠시 후 다시 시도해주세요.",
            cancelButton: "확인",
            style: .default,
            handler: nil
        )
    }

    private func presentSignUpErrAlert() {
        presentAlert(
            title: "회원가입 실패",
            message: "잠시 후 다시 시도해주세요.",
            cancelButton: "확인",
            style: .default,
            handler: nil
        )
    }
}
