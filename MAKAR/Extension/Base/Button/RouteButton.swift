//
//  RouteButton.swift
//  MAKAR
//
//  Created by 김다은 on 12/27/23.
//

import UIKit

class RouteButton: BaseButton {
    override init() {
        super.init()
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureUI() {
        setTitleColor(.white, for: .normal)
        backgroundColor = .makarBlue
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        layer.cornerRadius = CGFloat(18)
    }
}
