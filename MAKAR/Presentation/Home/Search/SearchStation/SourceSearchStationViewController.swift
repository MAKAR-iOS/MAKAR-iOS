//
//  SearchStationViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit
class SearchStationViewController : BaseViewController {
    
    // MARK: UI Components
    private let searchStationView = SearchStationView()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        
        view.addSubview(searchStationView)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        // TODO: Layout 수정
        searchStationView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
