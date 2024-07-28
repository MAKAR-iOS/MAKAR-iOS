//
//  SignUpViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 7/23/24.
//

import UIKit

class SignUpViewController: BaseViewController {
    
    // MARK: UI Components
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

        view.addSubview(signUpView)

        signUpView.tapConfirmButton = { [weak self] in
            guard let self else { return }
            // modal
            router.popViewController()
            presentAlert(
                title: "회원가입 성공",
                message: "회원가입에 성공하였습니다.",
                cancelButton: "확인",
                style: .destructive,
                handler: { _ in }
            )
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        signUpView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
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
    private func presentAlert(
        title: String,
        message: String?,
        cancelButton: String,
        style: UIAlertAction.Style,
        handler: ((UIAlertAction) -> Void)?
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        let cancelButton = UIAlertAction(
            title: cancelButton,
            style: .default)

        alertController.addAction(cancelButton)

        present(alertController, animated: true)
    }
}
