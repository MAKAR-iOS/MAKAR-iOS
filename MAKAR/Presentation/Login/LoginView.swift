//
//  LoginView.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class LoginView: BaseView {
    
    // MARK: Constants
    private enum Metric {
        static let logoWidth = 200
        static let logoHeight = 40
        static let buttonHeight = 50
        static let buttonRadius = 6
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

    private let appleLoginButton = BaseButton().then {
        $0.setTitle("Apple로 로그인", for: .normal)
        $0.setImage(MakarImage.appleLogo, for: .normal)
        $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 10)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = CGFloat(Metric.buttonRadius)
    }


    private let kakaoLoginButton = BaseButton().then {
        $0.setTitle("카카오톡으로 로그인", for: .normal)
        $0.setImage(MakarImage.kakaoLogo, for: .normal)
        $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 10)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        $0.backgroundColor = .kakaoYellow
        $0.layer.cornerRadius = CGFloat(Metric.buttonRadius)
    }

    // MARK: Properties
    var tapAppleLogin: (() -> Void)?
    var tapKakaoLogin: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(makarLabel)
        addSubview(makarLogoImageView)
        addSubview(appleLoginButton)
        addSubview(kakaoLoginButton)

        appleLoginButton.addTarget(self, action: #selector(handleAppleLoginEvent), for: .touchUpInside)
        kakaoLoginButton.addTarget(self, action: #selector(handleKakaoLoginEvent), for: .touchUpInside)
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

        appleLoginButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(690)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.buttonHeight)
        }

        kakaoLoginButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(752)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.buttonHeight)
        }
    }

    // MARK: Event
    @objc private func handleAppleLoginEvent() {
        tapAppleLogin?()
    }

    @objc private func handleKakaoLoginEvent() {
        tapKakaoLogin?()
    }
}
