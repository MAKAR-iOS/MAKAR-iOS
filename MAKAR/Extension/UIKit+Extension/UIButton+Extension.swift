//
//  UIButton+Extension.swift
//  MAKAR
//
//  Created by 박지윤 on 7/23/24.
//

import UIKit

extension UIButton {
    func setAuthDefaultButton(_ inputTitle: String) {
        setTitle(inputTitle, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        layer.cornerRadius = Metric.authButtonRadius
    }

    func setRouteDefaultButton(_ inputTitle: String) {
        setTitle(inputTitle, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        layer.cornerRadius = Metric.makarButtonRadius
    }

    func setAuthButton() {
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor = .makarBlue
        isEnabled = true
    }

    func setRouteButton() {
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor = .makarBlue
        isEnabled = true
    }

    func setUnabledButton() {
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor = .lightGray5
        isEnabled = false
    }

    func setReverseButton() {
        setTitleColor(UIColor.makarBlue, for: .normal)
        backgroundColor = .white
        layer.borderColor = UIColor.makarBlue.cgColor
        layer.borderWidth = 1
    }
}
