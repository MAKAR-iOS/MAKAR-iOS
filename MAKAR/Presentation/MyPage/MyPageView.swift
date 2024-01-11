//
//  MyPageView.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class MyPageView: BaseView {

    // MARK: Constants
    private enum Metric {
        static let profileImageSize = 60
        static let dividerHeight = 10
    }
    
    // MARK: UI Components
    private let userProfileImageView = UIImageView().then{
        $0.image = MakarImage.profile
    }
    
    private let userNameLabel = UILabel().then{
        $0.text = "김마카"+"님"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    private let userLoginLabel = UILabel().then{
        $0.text = "카카오 로그인 계정"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .lightGray
    }
    
    private let divider = UIView().then{
        $0.backgroundColor = .divider
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        
        addSubview(userProfileImageView)
        addSubview(userNameLabel)
        addSubview(userLoginLabel)
        addSubview(divider)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        userProfileImageView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(20)
            $0.height.width.equalTo(Metric.profileImageSize)
        }
        
        userNameLabel.snp.makeConstraints{
            $0.top.equalTo(userProfileImageView.snp.top).inset(8)
            $0.leading.equalTo(userProfileImageView.snp.trailing).inset(-10)
        }
        
        userLoginLabel.snp.makeConstraints{
            $0.leading.equalTo(userProfileImageView.snp.trailing).inset(-10)
            $0.bottom.equalTo(userProfileImageView.snp.bottom).inset(8)
        }
        
        divider.snp.makeConstraints{
            $0.top.equalTo(userProfileImageView.snp.bottom).inset(-10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Metric.dividerHeight)
        }
    }
}
