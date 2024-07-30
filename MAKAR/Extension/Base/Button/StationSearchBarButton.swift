//
//  StationSearchBarButton.swift
//  MAKAR
//
//  Created by 박지윤 on 7/30/24.
//

import UIKit

class StationSearchBarButton: BaseButton {
    // MARK: Properties
    private var inputTitle: String

    // MARK: Initializer
    init(setTitle: String) {
        self.inputTitle = setTitle
        super.init()

        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configuration
    private func configureUI() {
        setTitle(inputTitle, for: .normal)
        setTitleColor(.darkGray, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        contentHorizontalAlignment = .left
        setImage(MakarButton.searchBarButton, for: .normal)
        contentEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 0)
        imageEdgeInsets = .init(top: 0, left: -7, bottom: 0, right: 0)
        backgroundColor = .systemGray6
        layer.cornerRadius = CGFloat(Metric.searchBarRadius)
    }
}
