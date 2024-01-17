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
        static let buttonWidth = 60
        static let buttonHeight = 28
        static let buttonRadius = 6
        static let textViewHeight = 35
        static let setButtonHeight = 45
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
    
    private let homeStationTextView = BaseButton().then{
        $0.setTitle("집 주변 지하철 역을 등록해주세요", for: .normal)
        $0.setTitleColor(.lightGray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
        $0.contentHorizontalAlignment = .left
        $0.contentEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 0)
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = CGFloat(Metric.buttonRadius)
    }
    
    private let schoolStationTextView = BaseButton().then{
        $0.setTitle("학교 주변 지하철 역을 등록해주세요", for: .normal)
        $0.setTitleColor(.lightGray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
        $0.contentHorizontalAlignment = .left
        $0.contentEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 0)
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = CGFloat(Metric.buttonRadius)
    }
    
    private let homeSearchStationButton = BaseButton().then{
        var title = AttributedString("역 검색")
        title.font =  UIFont.systemFont(ofSize: 12)
        var config = UIButton.Configuration.filled()
        config.attributedTitle = title
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .lightGray2
        config.cornerStyle = .large
        $0.configuration = config
    }
    
    private let schoolSearchStationButton = BaseButton().then{
        var title = AttributedString("역 검색")
        title.font =  UIFont.systemFont(ofSize: 12)
        var config = UIButton.Configuration.filled()
        config.attributedTitle = title
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .lightGray2
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
        
        homeStationTextView.addTarget(self, action: #selector(handleHomeSearchStationButtonClickEvent), for: .touchUpInside)
        schoolStationTextView.addTarget(self, action: #selector(handleSchoolSearchStationButtonClickEvent), for: .touchUpInside)
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
            $0.centerY.equalTo(homeSearchStationButton)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(homeSearchStationButton.snp.leading).inset(-10)
            $0.height.equalTo(Metric.textViewHeight)
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
            $0.centerY.equalTo(schoolSearchStationButton)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(schoolSearchStationButton.snp.leading).inset(-10)
            $0.height.equalTo(Metric.textViewHeight)
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
