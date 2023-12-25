//
//  SplashView.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class SplashView: BaseView {

    // MARK: UI Components
    private let splashLabel = UILabel().then {
        $0.text = "지하철 막차 알림 서비스"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 24)
    }

    private let splashImageView = UIImageView().then {
        $0.image = MakarImage.makarLogo
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(splashLabel)
        addSubview(splashImageView)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        splashLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(280)
            $0.leading.equalToSuperview().inset(40)
        }

        splashImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(325)
            $0.leading.equalToSuperview().inset(40)
            $0.width.equalTo(200)
            $0.height.equalTo(40)
        }
    }
}
