//
//  BaseView.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/20.
//

import UIKit

class BaseView: UIView {
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configuration
    func configureSubviews() {
        
    }
    
    // MARK: Layout
    func makeConstraints() {
        
    }
}
