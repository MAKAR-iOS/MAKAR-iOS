//
//  SplashView.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class SplashView: BaseView {

    // MARK: Constants
    private enum Metric {
        static let logoWidth = 200
        static let logoHeight = 40
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

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(makarLabel)
        addSubview(makarLogoImageView)
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
    }
}
