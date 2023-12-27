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
        
        sourceSearchStationView.tapMyLocationButton = {[weak self] in
            guard let self else { return }
            postMyLocationButtonClicked()
        }
        
        sourceSearchStationView.tapHomeButton = {[weak self] in
            guard let self else { return }
            postHomeButtonClicked()
        }
        
        sourceSearchStationView.tapSchoolButton = {[weak self] in
            guard let self else { return }
            postSchoolButtonClicked()
        }
        
        sourceSearchStationView.tapMoreButton = {[weak self] in
            guard let self else { return }
            postMoreButtonClicked()
        }
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        // TODO: Layout 수정
        sourceSearchStationView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: Networking
    private func postMyLocationButtonClicked(){
        print("myLocationButton clicked")
    }
    
    private func postHomeButtonClicked(){
        print("homeButton clicked")
    }
    
    private func postSchoolButtonClicked(){
        print("schoolButton clicked")
    }
    
    private func postMoreButtonClicked(){
        print("moreButton clicked")
    }
    
    // MARK: NavigationBar
    private func setNavigationBar(){
        navigationItem.title = "출발역 입력"
    }
}
