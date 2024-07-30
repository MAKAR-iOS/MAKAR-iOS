//
//  UILabel+Extension.swift
//  MAKAR
//
//  Created by 박지윤 on 7/23/24.
//

import UIKit

extension UILabel {
    func setSignUpLabel(_ setText: String) {
        text = setText
        textColor = .black
        font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
}
