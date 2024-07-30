//
//  SearchStationView.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit
class BaseSearchStationView : BaseView {
    // MARK: UI Components
    let stationSearchBar = StationSearchBar(frame: .zero, placeholder: "역을 검색해주세요")

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        
        addSubview(stationSearchBar)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        stationSearchBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(10)
            $0.horizontalEdges.equalToSuperview().inset(15)
            $0.height.equalTo(Metric.searchBarHeight)
        }
    }
}
