//
//  StartSignInView.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class StartSignInView: BaseView {
    
    // MARK: UI Components
    private let makarLabel = UILabel().then {
        $0.text = "지하철 막차 알림 서비스"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 24)
    }

    private let makarLogoImageView = UIImageView().then {
        $0.image = MakarImage.makarLogo
    }

    private let signInButton = BaseButton().then {
        $0.setAuthDefaultButton("로그인")
        $0.setReverseButton()
    }

    private let signUpButton = BaseButton().then {
        $0.setAuthDefaultButton("회원가입")
        $0.setAuthButton()
    }

    // MARK: Properties
    var tapSignInButton: (() -> Void)?
    var tapSignUpButton: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        self.backgroundColor = .background

        addSubview(makarLabel)
        addSubview(makarLogoImageView)
        addSubview(signInButton)
        addSubview(signUpButton)

        signInButton.addTarget(self, action: #selector(handleSignInEvent), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(handleSignUpEvent), for: .touchUpInside)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        makarLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(280)
            $0.leading.equalToSuperview().inset(40)
        }

        makarLogoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(325)
            $0.leading.equalToSuperview().inset(40)
            $0.width.equalTo(Metric.logoWidth)
            $0.height.equalTo(Metric.logoHeight)
        }

        signInButton.snp.makeConstraints {
            $0.bottom.equalTo(signUpButton.snp.top).offset(-13)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.authButtonHeight)
        }

        signUpButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(68)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.authButtonHeight)
        }
    }

    // MARK: Event
    @objc private func handleSignInEvent() {
        tapSignInButton?()
    }

    @objc private func handleSignUpEvent() {
        tapSignUpButton?()
    }
}
