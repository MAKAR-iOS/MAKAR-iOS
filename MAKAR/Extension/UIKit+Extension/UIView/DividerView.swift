//
//  DividerView.swift
//  MAKAR
//
//  Created by 박지윤 on 7/29/24.
//

import UIKit

enum Divider {
    case thin
    case thick

    var height: CGFloat {
        switch self {
        case .thin:
            return 2.0
        case .thick:
            return 8.0
        }
    }
}

class DividerView: BaseView {

    // MARK: UI Component
    private let dividerView = UIView().then {
        $0.backgroundColor = .divider
    }

    // MARK: Properties
    private var dividerType: Divider

    // MARK: Initializer
    init(dividerType: Divider) {
        self.dividerType = dividerType
        super.init(frame: .zero)

        configureSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(dividerView)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        dividerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(dividerType.height)
        }
    }
}

