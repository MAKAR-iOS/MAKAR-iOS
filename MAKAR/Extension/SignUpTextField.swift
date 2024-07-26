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

    // MARK: Configuration
    override func configureSubviews(){
        super.configureSubviews()

        self.signUpTextField.delegate = self
        self.signUpTextField.setSignInTextField(inputPlaceholder)

        self.addSubview(signUpTextField)
        self.addSubview(underlineView)
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
    }

    func setPlaceholder(_ placeholder: String) {
        inputPlaceholder = placeholder
        signUpTextField.placeholder = placeholder

        signUpTextField.backgroundColor = .clear
        signUpTextField.layer.borderColor = UIColor.clear.cgColor
        signUpTextField.textColor = .black
        signUpTextField.font = UIFont.systemFont(ofSize: 15.5, weight: .medium)
    }

    func setSecureTextEntry() {
        signUpTextField.isSecureTextEntry = true
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
