//
//  StationSearchBar.swift
//  MAKAR
//
//  Created by 박지윤 on 7/30/24.
//

import UIKit

class StationSearchBar: UISearchBar {
    // MARK: Initializer
    init(frame: CGRect, placeholder: String) {
        super.init(frame: frame)
        self.placeholder = placeholder

        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configuration
    private func configureUI() {
        searchTextField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        searchTextField.textColor = .darkGray
        searchTextField.backgroundColor = .systemGray6
        searchBarStyle = .minimal
        setSearchFieldBackgroundImage(UIImage(), for: .normal)
        searchTextField.layer.cornerRadius = CGFloat(Metric.searchBarRadius)
        searchTextField.layer.masksToBounds = true
    }
}
