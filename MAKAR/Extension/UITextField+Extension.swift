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
        layer.cornerRadius = Metric.textFieldRadius
        textColor = .black
    }

    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: frame.height))
        leftView = paddingView
        leftViewMode = ViewMode.always
    }
}
