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
//        view.addSubview(signUpView)

        signUpView.tapConfirmButton = { [weak self] in
            guard let self else { return }
            presentAlert(
                title: "회원가입 성공",
                message: "회원가입에 성공하였습니다.",
                cancelButton: "확인",
                style: .destructive,
                handler: { action in self.router.popViewController() }
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
