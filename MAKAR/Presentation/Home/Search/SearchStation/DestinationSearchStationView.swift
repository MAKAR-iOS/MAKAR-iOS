//
//  DestinationSearchStationView.swift
//  MAKAR
//
//  Created by 김다은 on 12/27/23.
//

import UIKit
class DestinationSearchStationView : BaseSearchStationView {
    // MARK: Constants
    private enum Metric {
        static let buttonHeight = 27
        static let buttonRadius = 12
    }
    
    // MARK: UI Components
    private let homeButton = BaseButton().then{
        $0.configuration = stationButtonConfigure(title: "집", image: MakarButton.homeButton)
    }
    
    private let schoolButton = BaseButton().then{
        $0.configuration = stationButtonConfigure(title: "학교", image: MakarButton.schoolButton)
    }
    
    private let moreButton = BaseButton().then{
        $0.configuration = stationButtonConfigure(title: "", image: MakarButton.moreRightButton)
    }
  
    // MARK: Properties
    var tapHomeButton: (() -> Void)?
    var tapSchoolButton: (() -> Void)?
    var tapMoreButton: (() -> Void)?
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        
        addSubview(homeButton)
        addSubview(schoolButton)
        addSubview(moreButton)
        
        homeButton.addTarget(self, action: #selector(handleHomeButtonClickEvent), for: .touchUpInside)
        schoolButton.addTarget(self, action: #selector(handleSchoolButtonClickEvent), for: .touchUpInside)
        moreButton.addTarget(self, action: #selector(handleMoreButtonClickEvent), for: .touchUpInside)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        homeButton.snp.makeConstraints{
            $0.top.equalTo(stationSearchBar.snp.bottom).inset(-10)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.buttonHeight)
        }
        
        schoolButton.snp.makeConstraints{
            $0.top.equalTo(homeButton)
            $0.leading.equalTo(homeButton.snp.trailing).inset(-10)
            $0.height.equalTo(Metric.buttonHeight)
        }
        
        moreButton.snp.makeConstraints{
            $0.top.equalTo(homeButton)
            $0.leading.equalTo(schoolButton.snp.trailing).inset(-10)
            $0.height.equalTo(Metric.buttonHeight)
        }
    }
    
    // MARK: Event
    @objc private func handleHomeButtonClickEvent() {
        tapHomeButton?()
    }
    
    @objc private func handleSchoolButtonClickEvent() {
        tapSchoolButton?()
    }
    
    @objc private func handleMoreButtonClickEvent() {
        tapMoreButton?()
    }
}

extension DestinationSearchStationView {
    
   static func stationButtonConfigure(title : String, image : UIImage) -> UIButton.Configuration{
        var title = AttributedString(title)
        title.font =  UIFont.systemFont(ofSize: 13, weight: .light)
        var config = UIButton.Configuration.plain()
        config.attributedTitle = title
        config.background.strokeColor = .black
        config.background.strokeWidth = 0.5
        config.baseForegroundColor = .black
        config.cornerStyle = .capsule
        config.image = image
        config.imagePadding = 5
        return config
    }
}
