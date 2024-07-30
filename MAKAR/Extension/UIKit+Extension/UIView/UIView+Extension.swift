//
//  UIView+Extension.swift
//  MAKAR
//
//  Created by 박지윤 on 7/24/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
