//
//  UITextField+Extension.swift
//  MAKAR
//
//  Created by 박지윤 on 7/23/24.
//

import UIKit

extension UITextField {
    func setSignInTextField(_ inputPlaceholder: String) {
        placeholder = inputPlaceholder
        backgroundColor = .white
        layer.borderColor = UIColor.lightGray4.cgColor
        layer.borderWidth = Metric.textFieldBorderWidth
        layer.cornerRadius = CGFloat(Metric.textFieldRadius)
        textColor = .black
    }
}
