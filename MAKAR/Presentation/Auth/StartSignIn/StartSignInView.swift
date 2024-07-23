//
//  StartSignInView.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class StartSignInView: BaseView {
    
    // MARK: Constants
    private enum Metric {
        static let logoWidth = 200
        static let logoHeight = 40
        static let buttonHeight = 56
        static let buttonRadius = 8
    }

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
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(UIColor.makarBlue, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.makarBlue.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = CGFloat(Metric.buttonRadius)
    }

    private let signUpButton = BaseButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        $0.backgroundColor = .makarBlue
        $0.layer.cornerRadius = CGFloat(Metric.buttonRadius)
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

        signInButton.addTarget(self, action: #selector(handleAppleLoginEvent), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(handleKakaoLoginEvent), for: .touchUpInside)
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
            $0.height.equalTo(Metric.buttonHeight)
        }

        signUpButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(68)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.buttonHeight)
        }
    }

    // MARK: Event
    @objc private func handleAppleLoginEvent() {
        tapSignInButton?()
    }

    @objc private func handleKakaoLoginEvent() {
        tapSignUpButton?()
    }
}
