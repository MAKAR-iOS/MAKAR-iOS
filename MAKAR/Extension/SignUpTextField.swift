//
//  SignUpTextField.swift
//  MAKAR
//
//  Created by 박지윤 on 7/26/24.
//

import UIKit

enum CharacterLimitType {
    case id
    case password
    case checkPassword
    case username
    case email
}

class SignUpTextField: BaseView {

    var inputPlaceholder: String = ""
    var passwordTextField: SignUpTextField?
    var signUpTextFieldType: CharacterLimitType = .id

    var validId: Bool = false
    var validUsername: Bool = false
    var validEmail: Bool = false

    var onPasswordChanged: (() -> Void)?
    var onStateChanged: (() -> Void)?

    // MARK: UI Components
    let signUpTextField = UITextField()

    private let underlineView = UIView().then {
        $0.backgroundColor = .lightGray5
    }

    private let uncheckImageView = UIImageView().then {
        $0.image = MakarButton.uncheckButton
    }

    let checkImageView = UIImageView().then {
        $0.image = MakarButton.checkButton
        $0.isHidden = true
    }

    private let warningLabel = UILabel().then {
        $0.textColor = .makarRed
        $0.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        $0.isHidden = true
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        signUpTextField.delegate = self
        signUpTextField.setSignInTextField(inputPlaceholder)

        addSubview(signUpTextField)
        addSubview(underlineView)
        addSubview(uncheckImageView)
        addSubview(checkImageView)
        addSubview(warningLabel)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        signUpTextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.horizontalEdges.equalToSuperview().inset(4)
        }
        
        underlineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(signUpTextField.snp.bottom).offset(5)
        }

        uncheckImageView.snp.makeConstraints {
            $0.height.equalTo(11)
            $0.width.equalTo(14)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(2)
        }

        checkImageView.snp.makeConstraints {
            $0.height.equalTo(11)
            $0.width.equalTo(14)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(2)
        }

        warningLabel.snp.makeConstraints {
            $0.top.equalTo(signUpTextField.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(4)
        }
    }

    func setPlaceholder(_ placeholder: String) {
        inputPlaceholder = placeholder
        signUpTextField.placeholder = placeholder

        signUpTextField.backgroundColor = .clear
        signUpTextField.layer.borderColor = UIColor.clear.cgColor
        signUpTextField.textColor = .black
        signUpTextField.font = UIFont.systemFont(ofSize: 15.5, weight: .medium)
        signUpTextField.autocorrectionType = .no
        signUpTextField.spellCheckingType = .no
    }

    func setSecureTextEntry() {
        signUpTextField.isSecureTextEntry = true
        signUpTextField.textContentType = .oneTimeCode
    }

    func setCheckImageView(_ isHidden: Bool) {
        checkImageView.isHidden = isHidden
        uncheckImageView.isHidden = !isHidden
        onStateChanged?()
    }

    func setWarningLabelHidden(_ isHidden: Bool, _ inputText: String?) {
        warningLabel.isHidden = isHidden
        warningLabel.text = inputText ?? ""
    }
}

extension SignUpTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.1) {
            self.underlineView.backgroundColor = .makarBlue
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.1) {
            self.underlineView.backgroundColor = .lightGray5
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        let characterLimit: Int

        switch signUpTextFieldType {
        case .id:
            characterLimit = 5
            checkValidId()
            if validId && updatedText.count >= characterLimit {
                setCheckImageView(false)
                setWarningLabelHidden(true, "")
            } else {
                setCheckImageView(true)
                if updatedText.count == 0 {
                    setWarningLabelHidden(true, "")
                } else {
                    setWarningLabelHidden(false, "이미 사용중인 아이디입니다.")
                }
            }
        case .password:
            characterLimit = 8
            if updatedText.count >= characterLimit {
                setCheckImageView(false)
                setWarningLabelHidden(true, "")
            } else {
                setCheckImageView(true)
                if updatedText.count == 0 {
                    setWarningLabelHidden(true, "")
                } else {
                    setWarningLabelHidden(false, "8자 이상의 비밀번호를 입력해주세요.")
                }
            }
            onPasswordChanged?()
        case .checkPassword:
            if updatedText.count > 0 && updatedText == passwordTextField?.signUpTextField.text {
                setCheckImageView(false)
                setWarningLabelHidden(true, "")
            } else {
                setCheckImageView(true)
                if updatedText.count == 0 {
                    setWarningLabelHidden(true, "")
                } else {
                    setWarningLabelHidden(false, "비밀번호가 일치하지 않습니다.")
                }
            }
        case .email:
            checkValidEmail()
            if validEmail && updatedText.count > 0 {
                setCheckImageView(false)
            } else {
                setCheckImageView(true)
            }
        case .username:
            checkValidUsername()
            if validUsername && updatedText.count > 0 {
                setCheckImageView(false)
                setWarningLabelHidden(true, "")
            } else {
                setCheckImageView(true)
                if updatedText.count == 0 {
                    setWarningLabelHidden(true, "")
                } else {
                    setWarningLabelHidden(false, "이미 사용중인 닉네임입니다.")
                }
            }
        }

        return true
    }
}

extension SignUpTextField {
    // MARK: Network

    // TODO: checkValidId
    func checkValidId() {
        // if true
        validId = true
        // if false
//        validId = false
    }

    // TODO: checkValidUsername
    func checkValidUsername() {
        // if true
        validUsername = true
        // if false
//        validUsername = false
    }

    func checkValidEmail() {
        // if true
        validEmail = true
        // if false
//        validEmail = false
    }
}
