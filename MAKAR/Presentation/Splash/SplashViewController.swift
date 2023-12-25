//
//  SplashViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class SplashViewController: BaseViewController {
    
    // MARK: UI Components
    private let splashView = SplashView()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.8) {
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            sceneDelegate?.changeRootViewToLoginViewController()
        }
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        view.addSubview(splashView)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        splashView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
