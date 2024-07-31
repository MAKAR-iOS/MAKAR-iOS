//
//  EmptyResultView.swift
//  MAKAR
//
//  Created by 박지윤 on 8/1/24.
//

import UIKit

class EmptyResultView: BaseView {
    // MARK: UI Component
    private let emptyLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    // MARK: Initializer
    init(_ inputText: String) {
        super.init(frame: .zero)
        emptyLabel.text = inputText

        configureSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        backgroundColor = .background

        addSubview(emptyLabel)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

