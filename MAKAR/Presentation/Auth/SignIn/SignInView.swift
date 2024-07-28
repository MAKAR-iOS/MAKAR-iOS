//
//  SignInView.swift
//  MAKAR
//
//  Created by 박지윤 on 7/23/24.
//

import UIKit

class SignInView: BaseView {

    // MARK: UI Components
    private let makarLabel = UILabel().then {
        $0.text = "지하철 막차 알림 서비스"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 24)
    }

    private let makarLogoImageView = UIImageView().then {
        $0.image = MakarImage.makarLogo
    }

    private let idTextField = UITextField().then {
        $0.setSignInTextField("아이디")
        $0.addLeftPadding()
    }

    private let passwordTextField = UITextField().then {
        $0.setSignInTextField("비밀번호")
        $0.addLeftPadding()
        $0.setSecureTextEntry()
    }

    private let signInButton = BaseButton().then {
        $0.setDefaultButton("로그인")
        $0.setUnabledButton()
    }

    private let signUpButton = BaseButton().then {
        $0.setTitle("회원가입 >", for: .normal)
        $0.setTitleColor(.lightGray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }

    private let dismissButton = BaseButton().then {
        $0.setImage(MakarButton.deleteButton, for: .normal)
    }

    // MARK: Properties
    var tapSignInButton: (() -> Void)?
    var tapSignUpButton: (() -> Void)?
    var tapDismissButton: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        self.backgroundColor = .background

        addSubview(makarLabel)
        addSubview(makarLogoImageView)
        addSubview(idTextField)
        addSubview(passwordTextField)
        addSubview(signInButton)
        addSubview(signUpButton)
        addSubview(dismissButton)

        idTextField.addTarget(self, action: #selector(checkTextFieldChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(checkTextFieldChange), for: .editingChanged)

        signInButton.addTarget(self, action: #selector(handleSignInEvent), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(handleSignUpEvent), for: .touchUpInside)
        dismissButton.addTarget(self, action: #selector(handleDismissEvent), for: .touchUpInside)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        makarLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(200)
            $0.leading.equalToSuperview().inset(82)
        }

        makarLogoImageView.snp.makeConstraints {
            $0.top.equalTo(makarLabel.snp.bottom).offset(18)
            $0.leading.equalToSuperview().inset(82)
            $0.width.equalTo(Metric.logoWidth)
            $0.height.equalTo(Metric.logoHeight)
        }

        idTextField.snp.makeConstraints {
            $0.top.equalTo(makarLogoImageView.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.textFieldHeight)
        }

        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(14)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.textFieldHeight)
        }

        signInButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.buttonHeight)
        }

        signUpButton.snp.makeConstraints {
            $0.top.equalTo(signInButton.snp.bottom).offset(21)
            $0.centerX.equalToSuperview()
        }

        dismissButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(73)
            $0.trailing.equalToSuperview().inset(25)
        }
    }

    // MARK: Event
    @objc private func checkTextFieldChange() {
        let isIdTextNotEmpty = !(idTextField.text?.isEmpty ?? true)
        let isPasswordTextNotEmpty = !(passwordTextField.text?.isEmpty ?? true)

        if isIdTextNotEmpty && isPasswordTextNotEmpty {
            signInButton.setMakarButton()
        } else {
            signInButton.setUnabledButton()
        }
    }

    @objc private func handleSignInEvent() {
        tapSignInButton?()
    }

    @objc private func handleSignUpEvent() {
        tapSignUpButton?()
    }

    @objc private func handleDismissEvent() {
        tapDismissButton?()
    }
}
