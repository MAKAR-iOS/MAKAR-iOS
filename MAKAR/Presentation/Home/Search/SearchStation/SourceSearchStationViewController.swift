//
//  SearchStationViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit
class SourceSearchStationViewController : BaseViewController {
    
    // MARK: UI Components
    private let sourceSearchStationView = SourceSearchStationView()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        setNavigationBar()
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        
        view.addSubview(sourceSearchStationView)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        // TODO: Layout 수정
        sourceSearchStationView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: NavigationBar
    private func setNavigationBar(){
        navigationItem.title = "출발역"
    }
}
