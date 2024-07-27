//
//  SearchRouteView.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit
class SearchRouteView : BaseView {
    
    // MARK: Constants
    private enum Metric {
        static let textWidth = 40
        static let buttonHeight = 43
        static let searchBarHeight = 38
        static let searchBarRadius = 18
        static let swapButtonHeight = 30
        static let swapButtonWidth = 30
        static let dividerHeight = 10
    }
    
    // MARK: UI Components
    private let sourceText = UILabel().then{
        $0.text = "출발역"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .darkGray
    }
    
    private let destinationText = UILabel().then{
        $0.text = "도착역"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .darkGray
    }
    
    private let sourceSearchBar = BaseButton().then{
        $0.setTitle("출발역을 입력하세요", for: .normal)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.contentHorizontalAlignment = .left
        $0.setImage(MakarButton.searchBarButton, for: .normal)
        $0.contentEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 0)
        $0.imageEdgeInsets = .init(top: 0, left: -5, bottom: 0, right: 0)
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = CGFloat(Metric.searchBarRadius)
    }
    
    private let destinationSearchBar = BaseButton().then{
        $0.setTitle("도착역을 입력하세요", for: .normal)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.contentHorizontalAlignment = .left
        $0.setImage(MakarButton.searchBarButton, for: .normal)
        $0.contentEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 0)
        $0.imageEdgeInsets = .init(top: 0, left: -5, bottom: 0, right: 0)
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = CGFloat(Metric.searchBarRadius)
    }
    
    private let swapButton = BaseButton().then{
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        config.image = MakarButton.swapButton
        $0.configuration = config
    }
    
    private let searchRouteButton = BaseRouteButton().then{
        $0.setTitle("경로 찾기", for: .normal)
    }
    
    private let divider = UIView().then{
        $0.backgroundColor = .divider
    }
    
    // MARK: Properties
    var tapSwapStationButton: (() -> Void)?
    var tapSourceSearchBar: (() -> Void)?
    var tapDestinationSearchBar: (() -> Void)?
    var tapSearchRouteButton: (() -> Void)?
    

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        
        addSubview(sourceText)
        addSubview(destinationText)
        addSubview(sourceSearchBar)
        addSubview(destinationSearchBar)
        addSubview(swapButton)
        addSubview(searchRouteButton)
        addSubview(divider)
        
        swapButton.addTarget(self, action: #selector(handleSwapButtonClickEvent), for: .touchUpInside)
        sourceSearchBar.addTarget(self, action: #selector(handleSourceSearchBarClickEvent), for: .touchUpInside)
        destinationSearchBar.addTarget(self, action: #selector(handleDestinationSearchBarClickEvent), for: .touchUpInside)
        searchRouteButton.addTarget(self, action: #selector(handleSearchRouteButtonClickEvent), for: .touchUpInside)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        sourceText.snp.makeConstraints{
            $0.top.equalTo(safeAreaLayoutGuide).inset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(Metric.textWidth)
        }
        
        destinationText.snp.makeConstraints{
            $0.top.equalTo(sourceText.snp.bottom).inset(-40)
            $0.leading.equalTo(sourceText.snp.leading)
            $0.width.equalTo(Metric.textWidth)
        }
        
        swapButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(sourceText.snp.bottom).inset(-25)
            $0.height.equalTo(Metric.swapButtonHeight)
            $0.width.equalTo(Metric.swapButtonWidth)
        }
        
        sourceSearchBar.snp.makeConstraints{
            $0.centerY.equalTo(sourceText)
            $0.leading.equalTo(sourceText.snp.trailing).inset(-8)
            $0.trailing.equalTo(swapButton.snp.leading).inset(-5)
            $0.height.equalTo(Metric.searchBarHeight)
        }
        
        destinationSearchBar.snp.makeConstraints{
            $0.centerY.equalTo(destinationText)
            $0.leading.equalTo(destinationText.snp.trailing).inset(-8)
            $0.trailing.equalTo(swapButton.snp.leading).inset(-5)
            $0.height.equalTo(Metric.searchBarHeight)
        }
        
        searchRouteButton.snp.makeConstraints{
            $0.top.equalTo(destinationSearchBar.snp.bottom).inset(-20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.buttonHeight)
        }
        
        divider.snp.makeConstraints{
            $0.top.equalTo(searchRouteButton.snp.bottom).inset(-10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Metric.dividerHeight)
        }
    }
    
    // MARK: Event
    @objc private func handleSwapButtonClickEvent() {
        tapSwapStationButton?()
    }
    
    @objc private func handleSourceSearchBarClickEvent() {
        tapSourceSearchBar?()
    }
    
    @objc private func handleDestinationSearchBarClickEvent() {
        tapDestinationSearchBar?()
    }
    
    @objc private func handleSearchRouteButtonClickEvent() {
        tapSearchRouteButton?()
    }
    
    func changeSearchBarText(sourceText : String, destinationText : String){
        self.sourceSearchBar.setTitle(sourceText, for: .normal)
        self.destinationSearchBar.setTitle(destinationText, for: .normal)
    }
    
}
