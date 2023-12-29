//
//  NotificationView.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class NotificationView: BaseView {

    // MARK: UI Components
    private let makarNotiView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 19
        $0.layer.shadowColor = UIColor.lightGray4.cgColor
        $0.layer.shadowOpacity = 0.35
        $0.layer.shadowOffset = .zero
        $0.layer.shadowRadius = 19
    }

    private let makarNotiLabel = UILabel().then {
        $0.text = "막차 알림"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }

    private let makarNotiAddButton = BaseButton().then {
        $0.setImage(MakarButton.addButton, for: .normal)
    }

    private let getOffNotiView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 19
        $0.layer.shadowColor = UIColor.lightGray4.cgColor
        $0.layer.shadowOpacity = 0.35
        $0.layer.shadowOffset = .zero
        $0.layer.shadowRadius = 19
    }

    private let getOffNotiLabel = UILabel().then {
        $0.text = "하차 알림"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }

    private let getOffNotiAddButton = BaseButton().then {
        $0.setTitle("없음", for: .normal)
        $0.setTitleColor(UIColor.lightGray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.imageEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 0)
        $0.setImage(MakarButton.moreBottomButton, for: .normal)
    }

    // MARK: Properties
    var tapMakarAdd: (() -> Void)?
    var tapGetOffAdd: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(makarNotiView)
        makarNotiView.addSubview(makarNotiLabel)
        makarNotiView.addSubview(makarNotiAddButton)

        addSubview(getOffNotiView)
        getOffNotiView.addSubview(getOffNotiLabel)
        getOffNotiView.addSubview(getOffNotiAddButton)

        makarNotiAddButton.addTarget(self, action: #selector(handleMakarAddEvent), for: .touchUpInside)
        getOffNotiAddButton.addTarget(self, action: #selector(handleGetOffAddEvent), for: .touchUpInside)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        makarNotiView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(60)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(54)
        }

        makarNotiLabel.snp.makeConstraints {
            $0.centerY.equalTo(makarNotiView.snp.centerY)
            $0.leading.equalTo(makarNotiView).inset(20)
        }

        makarNotiAddButton.snp.makeConstraints {
            $0.centerY.equalTo(makarNotiView.snp.centerY)
            $0.trailing.equalTo(makarNotiView).inset(20)
            $0.height.width.equalTo(13)
        }

        getOffNotiView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(140)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(54)
        }

        getOffNotiLabel.snp.makeConstraints {
            $0.centerY.equalTo(getOffNotiView.snp.centerY)
            $0.leading.equalTo(getOffNotiView).inset(20)
        }

        getOffNotiAddButton.snp.makeConstraints {
            $0.centerY.equalTo(getOffNotiView.snp.centerY)
            $0.trailing.equalTo(getOffNotiView).inset(22)
            $0.height.equalTo(20)
            $0.width.equalTo(48)
        }
    }

    // MARK: Event
    @objc private func handleMakarAddEvent() {
        tapMakarAdd?()
    }

    @objc private func handleGetOffAddEvent() {
        tapGetOffAdd?()
    }
}
