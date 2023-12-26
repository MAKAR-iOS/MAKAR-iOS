//
//  HomeView.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class HomeView: BaseView {
    
    // MARK: Constants
    private enum Metric {
        static let buttonHeight = 45
        static let buttonRadius = 16
    }
    
    // MARK: UI Components
    private let setRouteButton = BaseButton().then {
        $0.setTitle("경로 설정하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .makarBlue
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        $0.layer.cornerRadius = CGFloat(Metric.buttonRadius)
    }
    
    // MARK: Properties
    var tapSetRouteButton: (() -> Void)?
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(setRouteButton)
        
        setRouteButton.addTarget(self, action: #selector(handleSetRouteButtonClickEvent), for: .touchUpInside)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        setRouteButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(490)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.buttonHeight)
        }
    }
    
    // MARK: Event
    @objc private func handleSetRouteButtonClickEvent() {
        tapSetRouteButton?()
    }
    
}
