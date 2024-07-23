//
//  UIPageViewController+Extension.swift
//  MAKAR
//
//  Created by 박지윤 on 1/23/24.
//

import UIKit

extension UIPageViewController {
    var scrollView: UIScrollView? {
        view.subviews.first as? UIScrollView
    }
}
