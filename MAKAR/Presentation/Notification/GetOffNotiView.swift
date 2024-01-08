//
//  GetOffNotiView.swift
//  MAKAR
//
//  Created by 박지윤 on 2024/01/08.
//

import UIKit


class GetOffNotiView: BaseView {

    let makarTimeArr = [5, 10, 15, 20, 25, 30]
    var tempMakarTime = 5
    var selectedMakarTime = 0

    // MARK: UI Components
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

    var getOffAlertController = UIAlertController(
        title: "하차 알림",
        message: nil,
        preferredStyle: .alert
    )

    // MARK: Properties
    var tapGetOffAdd: (() -> Void)?

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        setGetOffNotiView()
        setGetOffAlertController()

        addSubview(getOffNotiLabel)
        addSubview(getOffNotiAddButton)

        getOffNotiAddButton.addTarget(self, action: #selector(handleGetOffAddEvent), for: .touchUpInside)
    }

    private func setGetOffNotiView() {
        backgroundColor = .white
        layer.cornerRadius = 19
        layer.shadowColor = UIColor.lightGray4.cgColor
        layer.shadowOpacity = 0.35
        layer.shadowOffset = .zero
        layer.shadowRadius = 19
    }

    func setGetOffAlertController() {
        let okAction = UIAlertAction(title: "추가", style: .destructive) { _ in

        }
        let cancelAction = UIAlertAction(title: "닫기", style: .cancel)

        getOffAlertController.addAction(okAction)
        getOffAlertController.addAction(cancelAction)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        getOffNotiLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }

        getOffNotiAddButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(22)
            $0.height.equalTo(20)
            $0.width.equalTo(48)
        }
    }

    // MARK: Event
    @objc private func handleGetOffAddEvent() {
        tapGetOffAdd?()
    }
}
