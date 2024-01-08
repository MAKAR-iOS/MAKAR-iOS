//
//  NotificationViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class NotificationViewController: BaseViewController {

    // MARK: UI Components
    private let notificationView = NotificationView()
    private let makarNotiView = MakarNotiView()
    private let getOffNotiView = GetOffNotiView()

    // MARK: Environment
    private let router = BaseRouter()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .background
        router.viewController = self
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        view.addSubview(notificationView)

        notificationView.makarNotiView.tapMakarAdd = {[weak self] in
            guard let self else { return }
            addMakarNoti()
        }

        notificationView.getOffNotiView.tapGetOffAdd = {[weak self] in
            guard let self else { return }
            addGetOffNoti()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        notificationView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: Event
    private func addMakarNoti() {
        self.present(makarNotiView.makarAlertController, animated: true)
    }

    private func addGetOffNoti() {
        self.present(getOffNotiView.getOffAlertController, animated: true)
    }
}
