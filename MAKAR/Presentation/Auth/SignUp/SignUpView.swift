//
//  SignUpView.swift
//  MAKAR
//
//  Created by 박지윤 on 7/23/24.
//

import UIKit

class SignUpView: BaseView {
    
    // MARK: UI Components
    private let idLabel = UILabel().then {
        $0.setSignUpLabel("아이디")
    }

    private let idTextField = SignUpTextField().then {
        $0.setPlaceholder("5자 이상의 아이디를 입력해주세요.")
    }

    private let passwordLabel = UILabel().then {
        $0.setSignUpLabel("비밀번호")
    }

    private let passwordTextField = SignUpTextField().then {
        $0.setPlaceholder("8자 이상의 비밀번호를 입력해주세요.")
        $0.setSecureTextEntry()
    }

    private let checkPasswordLabel = UILabel().then {
        $0.setSignUpLabel("비밀번호 확인")
    }

    private let checkPasswordTextField = SignUpTextField().then {
        $0.setPlaceholder("비밀번호를 한번 더 입력해주세요.")
        $0.setSecureTextEntry()
    }

    private let nickNameLabel = UILabel().then {
        $0.setSignUpLabel("닉네임")
    }

    private let nickNameTextField = SignUpTextField().then {
        $0.setPlaceholder("사용하실 닉네임을 입력해주세요.")
    }

    private let signUpStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 40
    }
    
    private let idStackView = UIStackView().then {
        $0.setSignUpStackView()
    }

    private let passwordStackView = UIStackView().then {
        $0.setSignUpStackView()
    }

    private let checkPasswordStackView = UIStackView().then {
        $0.setSignUpStackView()
    }

    private let nickNameStackView = UIStackView().then {
        $0.setSignUpStackView()
    }

    private let confirmButton = BaseButton().then {
        $0.setDefaultButton("입력 완료")
    }

    // MARK: Properties
    var tapConfirmButton: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        self.backgroundColor = .background

        addSubview(signUpStackView)
        addSubview(confirmButton)

        signUpStackView.addArrangedSubviews(idStackView,
                                            passwordStackView,
                                            checkPasswordStackView,
                                            nickNameStackView)

        idStackView.addArrangedSubviews(idLabel, idTextField)
        passwordStackView.addArrangedSubviews(passwordLabel, passwordTextField)
        checkPasswordStackView.addArrangedSubviews(checkPasswordLabel, checkPasswordTextField)
        nickNameStackView.addArrangedSubviews(nickNameLabel, nickNameTextField)

        confirmButton.addTarget(self, action: #selector(handleConfirmvent), for: .touchUpInside)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        signUpStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(28)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(360)
        }

        idStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(60)
        }

        passwordStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(60)
        }

        checkPasswordStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(60)
        }

        nickNameStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(60)
        }

        confirmButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(57)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(Metric.buttonHeight)
        }
    }

    // MARK: Event
    @objc private func handleConfirmvent() {
        tapConfirmButton?()
    }
}
