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
        setTitleColor(UIColor.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        backgroundColor = .makarBlue
        layer.cornerRadius = CGFloat(Metric.buttonRadius)
    }
}
