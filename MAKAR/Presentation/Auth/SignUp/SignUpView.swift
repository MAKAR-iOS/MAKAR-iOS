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
        $0.signUpTextFieldType = .id
    }

    private let passwordLabel = UILabel().then {
        $0.setSignUpLabel("비밀번호")
    }

    private let passwordTextField = SignUpTextField().then {
        $0.setPlaceholder("8자 이상의 비밀번호를 입력해주세요.")
        $0.setSecureTextEntry()
        $0.signUpTextFieldType = .password
    }

    private let checkPasswordLabel = UILabel().then {
        $0.setSignUpLabel("비밀번호 확인")
    }

    private let checkPasswordTextField = SignUpTextField().then {
        $0.setPlaceholder("비밀번호를 한번 더 입력해주세요.")
        $0.setSecureTextEntry()
        $0.signUpTextFieldType = .checkPassword
    }

    private let emailLabel = UILabel().then {
        $0.setSignUpLabel("이메일")
    }

    private let emailTextField = SignUpTextField().then {
        $0.setPlaceholder("사용하실 이메일을 입력해주세요.")
        $0.signUpTextFieldType = .email
    }

    private let nickNameLabel = UILabel().then {
        $0.setSignUpLabel("닉네임")
    }

    private let nickNameTextField = SignUpTextField().then {
        $0.setPlaceholder("사용하실 닉네임을 입력해주세요.")
        $0.signUpTextFieldType = .nickName
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

    private let emailStackView = UIStackView().then {
        $0.setSignUpStackView()
    }

    private let nickNameStackView = UIStackView().then {
        $0.setSignUpStackView()
    }

    private let confirmButton = BaseButton().then {
        $0.setDefaultButton("입력 완료")
        $0.setUnabledButton()
    }

    // MARK: Properties
    var tapConfirmButton: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        self.backgroundColor = .background
        manageCheckPassword()
        checkTextFieldChange()

        addSubview(signUpStackView)
        addSubview(confirmButton)

        signUpStackView.addArrangedSubviews(idStackView,
                                            passwordStackView,
                                            checkPasswordStackView,
                                            emailStackView,
                                            nickNameStackView)

        idStackView.addArrangedSubviews(idLabel, idTextField)
        passwordStackView.addArrangedSubviews(passwordLabel, passwordTextField)
        checkPasswordStackView.addArrangedSubviews(checkPasswordLabel, checkPasswordTextField)
        emailStackView.addArrangedSubviews(emailLabel, emailTextField)
        nickNameStackView.addArrangedSubviews(nickNameLabel, nickNameTextField)

        confirmButton.addTarget(self, action: #selector(handleConfirmEvent), for: .touchUpInside)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        signUpStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(28)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(460)
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

        emailStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(60)
        }

        nickNameStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(60)
        }

        confirmButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(30)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(Metric.buttonHeight)
        }
    }

    // MARK: Event
    @objc private func handleConfirmEvent() {
        tapConfirmButton?()
    }
}

extension SignUpView {
    private func manageCheckPassword() {
        self.checkPasswordTextField.passwordTextField = self.passwordTextField

        passwordTextField.onPasswordChanged = { [self,  weak checkPasswordTextField] in
            guard let checkPasswordTextField = checkPasswordTextField else { return }
            if checkPasswordTextField.signUpTextField.text == passwordTextField.signUpTextField.text {
                checkPasswordTextField.setCheckImageView(false)
                checkPasswordTextField.setWarningLabelHidden(true, "")
            } else {
                checkPasswordTextField.setCheckImageView(true)
                if checkPasswordTextField.signUpTextField.text?.count == 0 {
                    checkPasswordTextField.setWarningLabelHidden(true, "")
                } else {
                    checkPasswordTextField.setWarningLabelHidden(false, "비밀번호가 일치하지 않습니다.")
                }
            }
        }
    }

    private func checkTextFieldChange() {
        idTextField.onStateChanged = { [weak self] in
            self?.setConfirmButtonEnabled()
        }

        passwordTextField.onStateChanged = { [weak self] in
            self?.setConfirmButtonEnabled()
        }

        checkPasswordTextField.onStateChanged = { [weak self] in
            self?.setConfirmButtonEnabled()
        }

        emailTextField.onStateChanged = { [weak self] in
            self?.setConfirmButtonEnabled()
        }

        nickNameTextField.onStateChanged = { [weak self] in
            self?.setConfirmButtonEnabled()
        }
    }

    private func setConfirmButtonEnabled() {
        let allFieldsChecked = [
            idTextField.checkImageView.isHidden == false,
            passwordTextField.checkImageView.isHidden == false,
            checkPasswordTextField.checkImageView.isHidden == false,
            emailTextField.checkImageView.isHidden == false,
            nickNameTextField.checkImageView.isHidden == false
        ].allSatisfy { $0 }

        if allFieldsChecked {
            confirmButton.setMakarButton()
        } else {
            confirmButton.setUnabledButton()
        }
    }
}
