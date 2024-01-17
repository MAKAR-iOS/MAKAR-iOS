//
//  GetOffNotiSetViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 1/17/24.
//


import UIKit

class GetOffNotiSetViewController: BaseViewController {

    // MARK: UI Components
    private let getOffNotiSetView = GetOffNotiSetView()

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

        view.addSubview(getOffNotiSetView)

        getOffNotiSetView.tapConfirmButton = {[weak self] in
            guard let self else { return }
            tapConfirm()
        }

        getOffNotiSetView.tapCancelButton = {[weak self] in
            guard let self else { return }
            tapCancel()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        getOffNotiSetView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: Event
    private func tapConfirm() {
        dismiss(animated: false)
    }

    private func tapCancel() {
        dismiss(animated: false)
    }
}
