//
//  UIButton+Extension.swift
//  MAKAR
//
//  Created by 박지윤 on 7/23/24.
//

import UIKit

extension UIButton {
    func setDefaultButton(_ inputTitle: String) {
        setTitle(inputTitle, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        layer.cornerRadius = Metric.buttonRadius
    }

    func setMakarButton() {
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor = .makarBlue
        isEnabled = true
    }

    func setUnabledButton() {
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor = .lightGray4
        isEnabled = false
    }

    func setReverseeButton() {
        setTitleColor(UIColor.makarBlue, for: .normal)
        backgroundColor = .white
        layer.borderColor = UIColor.makarBlue.cgColor
        layer.borderWidth = 1
    }
}
