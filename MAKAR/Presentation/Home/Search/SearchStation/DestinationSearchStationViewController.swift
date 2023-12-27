//
//  DestinationSearchStationViewController.swift
//  MAKAR
//
//  Created by 김다은 on 12/27/23.
//

import UIKit
class DestinationSearchStationViewController : BaseViewController {
    
    // MARK: UI Components
    private let destinationSearchStationView = DestinationSearchStationView()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        setNavigationBar()
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        
        view.addSubview(destinationSearchStationView)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        // TODO: Layout 수정
        destinationSearchStationView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: NavigationBar
    private func setNavigationBar(){
        navigationItem.title = "도착역"
    }
}
