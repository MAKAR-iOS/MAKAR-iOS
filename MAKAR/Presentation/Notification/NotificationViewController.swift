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

        notificationView.tapMakarAdd = {[weak self] in
            guard let self else { return }
            addMakarNoti()
        }

        notificationView.tapGetOffAdd = {[weak self] in
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

    // MARK: Networking
    private func addMakarNoti() {
        print("addMakarNoti called")
    }

    private func addGetOffNoti() {
        print("addGetOffNoti called")
    }
}
