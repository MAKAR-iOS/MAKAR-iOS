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
        static let buttonHeight = 30
        static let dividerHeight = 12
    }
    
    // MARK: UI Components
    private let homeButton = BaseButton().then{
//        $0.configuration = stationButtonConfigure(title: "집", image: MakarButton.homeButton)
        let systemImageConfig = UIImage.SymbolConfiguration(paletteColors: [.darkgray2])
        $0.configuration = stationButtonConfigure(title: "집", image: UIImage(systemName: "house", withConfiguration: systemImageConfig)!)
    }
    
    private let schoolButton = BaseButton().then{
//        $0.configuration = stationButtonConfigure(title: "학교", image: MakarButton.schoolButton)
        let systemImageConfig = UIImage.SymbolConfiguration(paletteColors: [.darkgray2])
        $0.configuration = stationButtonConfigure(title: "학교", image: UIImage(systemName: "graduationcap", withConfiguration: systemImageConfig)!)
    }
    
    private let moreButton = BaseButton().then{
        $0.configuration = stationButtonConfigure(title: "", image: MakarButton.moreRightButton)
    }
    
    private let divider = UIView().then{
        $0.backgroundColor = .divider
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
        addSubview(divider)
        
        homeButton.addTarget(self, action: #selector(handleHomeButtonClickEvent), for: .touchUpInside)
        schoolButton.addTarget(self, action: #selector(handleSchoolButtonClickEvent), for: .touchUpInside)
        moreButton.addTarget(self, action: #selector(handleMoreButtonClickEvent), for: .touchUpInside)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        homeButton.snp.makeConstraints{
            $0.top.equalTo(stationSearchBar.snp.bottom).inset(-15)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.buttonHeight)
        }
        
        schoolButton.snp.makeConstraints{
            $0.top.equalTo(homeButton)
            $0.leading.equalTo(homeButton.snp.trailing).inset(-8)
            $0.height.equalTo(Metric.buttonHeight)
        }
        
        moreButton.snp.makeConstraints{
            $0.top.equalTo(homeButton)
            $0.leading.equalTo(schoolButton.snp.trailing).inset(-8)
            $0.height.equalTo(Metric.buttonHeight)
        }
        
        divider.snp.makeConstraints{
            $0.top.equalTo(homeButton.snp.bottom).inset(-20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Metric.dividerHeight)
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
       title.font =  UIFont.systemFont(ofSize: 13, weight: .medium)
        var config = UIButton.Configuration.plain()
        config.attributedTitle = title
        config.background.strokeColor = .darkgray
        config.background.strokeWidth = 0.8
        config.baseForegroundColor = .darkgray
        config.cornerStyle = .capsule
        config.image = image
        config.imagePadding = 3
       config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize:13)
        return config
    }
}
