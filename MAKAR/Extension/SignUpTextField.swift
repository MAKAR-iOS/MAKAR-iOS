//
//  SignUpTextField.swift
//  MAKAR
//
//  Created by 박지윤 on 7/26/24.
//

import UIKit.UITextField

class SignUpTextField: BaseView {

    var inputPlaceholder: String = ""

    // MARK: UI Components
    private let signUpTextField = UITextField()

    private let underlineView = UIView().then {
        $0.backgroundColor = .lightGray4
    }

    private let uncheckImageView = UIImageView().then {
        $0.image = MakarButton.uncheckButton

    }

    private let checkImageView = UIImageView().then {
        $0.image = MakarButton.checkButton
        $0.isHidden = true
    }

    // MARK: Configuration
    override func configureSubviews(){
        super.configureSubviews()

        signUpTextField.delegate = self
        signUpTextField.setSignInTextField(inputPlaceholder)

        addSubview(signUpTextField)
        addSubview(underlineView)
        addSubview(uncheckImageView)
        addSubview(checkImageView)
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
    }

    func checkTextField() {
        checkImageView.isHidden = false
        uncheckImageView.isHidden = true
    }

    func uncheckTextField() {
        checkImageView.isHidden = true
        uncheckImageView.isHidden = false
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
            self.underlineView.backgroundColor = .lightGray4
        }
    }
}
