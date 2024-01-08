//
//  NotificationView.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class NotificationView: BaseView {

    // MARK: UI Components
    let makarNotiView = MakarNotiView()
    let getOffNotiView = GetOffNotiView()

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(makarNotiView)
        addSubview(getOffNotiView)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        makarNotiView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(160)
        }

        getOffNotiView.snp.makeConstraints {
            $0.top.equalTo(makarNotiView.snp.bottom).offset(26)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(54)
        }
    }
}
