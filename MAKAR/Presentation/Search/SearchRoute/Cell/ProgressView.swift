//
//  ProgressView.swift
//  MAKAR
//
//  Created by 김다은 on 1/21/24.
//

import UIKit

class ProgressView: UILabel {
    
    // MARK: Constants
    private enum Metric {
        static let selfHeight = 20
        static let radius = 10
        static let imageSize = 12
    }
    
    init(color: UIColor, text: String) {
        super.init(frame: .infinite)
        
        configure()
        setData(color: color, text: text)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configuration
    private func configure() {
        //text
        textColor = .white
        textAlignment = .center
        font = .systemFont(ofSize: 12, weight: .regular)
        
        //layer
        backgroundColor = .divider
        clipsToBounds = true
        layer.cornerRadius = CGFloat(Metric.radius)
    }
    
    // MARK: Layout
    private func makeConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(Metric.selfHeight)
        }
    }
    
    private func setData(color: UIColor, text: String) {
        self.backgroundColor = color
        let attributedString = NSMutableAttributedString(string: "")
        
        if(color == .divider) {
            self.textColor = .darkGray
        } else {
            //지하철 이미지 추가
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = MakarButton.myRouteButton
            imageAttachment.bounds = CGRect(x: 0, y: -2, width: Metric.imageSize, height: Metric.imageSize)
            attributedString.append(NSAttributedString(attachment: imageAttachment))
        }
        attributedString.append(NSAttributedString(string: text))
        self.attributedText = attributedString
    }
}
