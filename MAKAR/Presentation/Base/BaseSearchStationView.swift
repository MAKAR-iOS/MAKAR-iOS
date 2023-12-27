//
//  SearchStationView.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit
class BaseSearchStationView : BaseView {
    // MARK: Constants
    private enum Metric {
        static let searchBarHeight = 38
        static let searchBarRadius = 22
    }
    
    // MARK: UI Components
    private let stationSearchBar = UISearchBar().then{
        $0.placeholder = "역을 검색해주세요"
        $0.searchTextField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.searchTextField.textColor = .darkgray
        $0.searchTextField.backgroundColor = .systemGray6
        $0.searchBarStyle = .minimal
        $0.setSearchFieldBackgroundImage(UIImage(), for: .normal)
        $0.searchTextField.layer.cornerRadius = CGFloat(Metric.searchBarRadius)
        $0.searchTextField.layer.masksToBounds = true
    }
    
    // MARK: Properties
    

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        
        addSubview(stationSearchBar)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        stationSearchBar.snp.makeConstraints{
            $0.top.equalTo(safeAreaLayoutGuide).inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.searchBarHeight)
        }
    }
}
