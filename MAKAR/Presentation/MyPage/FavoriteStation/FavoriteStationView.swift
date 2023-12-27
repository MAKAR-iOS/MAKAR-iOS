//
//  FavoriteStationView.swift
//  MAKAR
//
//  Created by 김다은 on 12/28/23.
//

import UIKit
class FavoriteStationView : BaseView {
    
    // MARK: Constants
    private enum Metric {
        static let buttonWidth = 62
        static let buttonHeight = 30
        static let buttonRadius = 6
        static let setButtonHeight = 50
    }
    
    // MARK: UI Components
    private let homeText = UILabel().then{
        $0.text = "집"
        $0.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    }
    
    private let schoolText = UILabel().then{
        $0.text = "학교"
        $0.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    }
    
    private let homeStationTextView = UITextField().then{
        // TODO: 수정 필요
        $0.textColor = .darkgray
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.backgroundColor = .red
    }
    
    private let schoolStationTextView = UITextField().then{
        // TODO: 수정 필요
        $0.textColor = .darkgray
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.backgroundColor = .red
    }
    
    private let homeSearchStationButton = BaseButton().then{
        var title = AttributedString("역 검색")
        title.font =  UIFont.systemFont(ofSize: 13)
        var config = UIButton.Configuration.filled()
        config.attributedTitle = title
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .lightgray2
        config.cornerStyle = .large
        $0.configuration = config
    }
    
    private let schoolSearchStationButton = BaseButton().then{
        var title = AttributedString("역 검색")
        title.font =  UIFont.systemFont(ofSize: 13)
        var config = UIButton.Configuration.filled()
        config.attributedTitle = title
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .lightgray2
        config.cornerStyle = .large
        $0.configuration = config
    }
    
    private let setButton = BaseButton().then{
        $0.setTitle("등록하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        $0.backgroundColor = .makarBlue
        $0.layer.cornerRadius = CGFloat(Metric.buttonRadius)
    }
    
    // MARK: Properties
    var tapHomeSearchStationButton: (() -> Void)?
    var tapSchoolSearchStationButton: (() -> Void)?
    var tapSetButton: (() -> Void)?
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        
        addSubview(homeText)
        addSubview(homeSearchStationButton)
        addSubview(homeStationTextView)
        addSubview(schoolText)
        addSubview(schoolSearchStationButton)
        addSubview(schoolStationTextView)
        addSubview(setButton)
        
        homeSearchStationButton.addTarget(self, action: #selector(handleHomeSearchStationButtonClickEvent), for: .touchUpInside)
        schoolSearchStationButton.addTarget(self, action: #selector(handleSchoolSearchStationButtonClickEvent), for: .touchUpInside)
        setButton.addTarget(self, action: #selector(handleSetButtonClickEvent), for: .touchUpInside)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        homeText.snp.makeConstraints{
            $0.top.equalTo(safeAreaLayoutGuide).inset(40)
            $0.leading.equalToSuperview().inset(20)
        }
        
        homeSearchStationButton.snp.makeConstraints{
            $0.top.equalTo(homeText.snp.bottom).inset(-10)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.buttonHeight)
            $0.width.equalTo(Metric.buttonWidth)
        }
        
        homeStationTextView.snp.makeConstraints{
            $0.top.equalTo(homeText.snp.bottom).inset(-10)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(homeSearchStationButton.snp.leading).inset(-10)
        }
        
        schoolText.snp.makeConstraints{
            $0.top.equalTo(homeStationTextView.snp.bottom).inset(-50)
            $0.leading.equalToSuperview().inset(20)
        }
        
        schoolSearchStationButton.snp.makeConstraints{
            $0.top.equalTo(schoolText.snp.bottom).inset(-10)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.buttonHeight)
            $0.width.equalTo(Metric.buttonWidth)
        }
        
        schoolStationTextView.snp.makeConstraints{
            $0.top.equalTo(schoolText.snp.bottom).inset(-10)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(schoolSearchStationButton.snp.leading).inset(-10)
        }
        
        setButton.snp.makeConstraints{
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.setButtonHeight)
        }
    }
    
    // MARK: Event
    @objc private func handleHomeSearchStationButtonClickEvent() {
        tapHomeSearchStationButton?()
    }
    
    @objc private func handleSchoolSearchStationButtonClickEvent() {
        tapSchoolSearchStationButton?()
    }
    
    @objc private func handleSetButtonClickEvent() {
        tapSetButton?()
    }
}
