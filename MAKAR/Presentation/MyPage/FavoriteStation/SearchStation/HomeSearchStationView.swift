//
//  HomeSearchStationView.swift
//  MAKAR
//
//  Created by 김다은 on 12/28/23.
//

import UIKit
class HomeSearchStationView : BaseSearchStationView {
    
    // MARK: Constants
    private enum Metric {
        static let dividerHeight = 12
    }
    
    // MARK: UI Components
    private let divider = UIView().then{
        $0.backgroundColor = .divider
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        
        addSubview(divider)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        divider.snp.makeConstraints{
            $0.top.equalTo(stationSearchBar.snp.bottom).inset(-20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Metric.dividerHeight)
        }
    }
}
