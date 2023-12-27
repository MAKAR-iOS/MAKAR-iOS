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
        static let buttonHeight = 43
        static let searchBarHeight = 38
        static let searchBarRadius = 22
    }
    
    // MARK: UI Components
    private let sourceText = UILabel().then{
        $0.text = "출발역"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .darkgray
    }
    
    private let destinationText = UILabel().then{
        $0.text = "도착역"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .darkgray
    }
    
    private let sourceSearchBar = UISearchBar().then{
        $0.placeholder = "출발역을 입력하세요"
        $0.searchTextField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.searchTextField.textColor = .darkgray
        $0.searchTextField.backgroundColor = .systemGray6
        $0.searchBarStyle = .minimal
        $0.setSearchFieldBackgroundImage(UIImage(), for: .normal)
        $0.searchTextField.layer.cornerRadius = CGFloat(Metric.searchBarRadius)
        $0.searchTextField.layer.masksToBounds = true
    }
    
    private let destinationSearchBar = UISearchBar().then{
        $0.placeholder = "도착역을 입력하세요"
        $0.searchTextField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.searchTextField.textColor = .darkgray
        $0.searchTextField.backgroundColor = .systemGray6
        $0.searchBarStyle = .minimal
        $0.setSearchFieldBackgroundImage(UIImage(), for: .normal)
        $0.searchTextField.layer.cornerRadius = CGFloat(Metric.searchBarRadius)
        $0.searchTextField.layer.masksToBounds = true
    }
    
    private let swapStationButton = BaseButton().then{
        $0.setImage(UIImage(named: "ic_swap"), for: .normal)
    }
    
    private let searchRouteButton = RouteBaseButton().then{
        $0.setTitle("경로 찾기", for: .normal)
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
        addSubview(swapStationButton)
        addSubview(searchRouteButton)
        
        swapStationButton.addTarget(self, action: #selector(handleSwapStationButtonClickEvent), for: .touchUpInside)
        sourceSearchBar.searchTextField.addTarget(self, action: #selector(handleSourceSearchBarClickEvent), for: .touchUpInside)
        destinationSearchBar.searchTextField.addTarget(self, action: #selector(handleDestinationSearchBarClickEvent), for: .touchUpInside)
        searchRouteButton.addTarget(self, action: #selector(handleSearchRouteButtonClickEvent), for: .touchUpInside)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        sourceText.snp.makeConstraints{
            $0.top.equalTo(safeAreaLayoutGuide).inset(20)
            $0.leading.equalToSuperview().inset(20)
        }
        
        destinationText.snp.makeConstraints{
            $0.top.equalTo(sourceText.snp.bottom).inset(-40)
            $0.leading.equalTo(sourceText.snp.leading)
        }
        
        swapStationButton.snp.makeConstraints{
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(sourceText.snp.bottom).inset(-25)
        }
        
        sourceSearchBar.snp.makeConstraints{
            $0.centerY.equalTo(sourceText)
            $0.leading.equalTo(sourceText.snp.trailing).inset(-5)
            $0.trailing.equalTo(swapStationButton.snp.leading)
            $0.height.equalTo(Metric.searchBarHeight)
        }
        
        destinationSearchBar.snp.makeConstraints{
            $0.centerY.equalTo(destinationText)
            $0.leading.equalTo(destinationText.snp.trailing).inset(-5)
            $0.trailing.equalTo(swapStationButton.snp.leading)
            $0.height.equalTo(Metric.searchBarHeight)
        }
        
        searchRouteButton.snp.makeConstraints{
            $0.top.equalTo(destinationSearchBar.snp.bottom).inset(-20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.buttonHeight)
        }
    }
    
    // MARK: Event
    @objc private func handleSwapStationButtonClickEvent() {
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
    
}
