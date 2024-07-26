//
//  FavoriteStationViewController.swift
//  MAKAR
//
//  Created by 김다은 on 12/28/23.
//

import UIKit
class FavoriteStationViewController : BaseViewController {
    
    // MARK: UI Components
    private let favoriteStationView = FavoriteStationView()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        
        view.backgroundColor = .background
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        
        view.addSubview(favoriteStationView)
        
        favoriteStationView.tapHomeSearchStationButton = {[weak self] in
            guard let self else { return }
            
            navigationController?.pushViewController(HomeSearchStationViewController(), animated: true)
            postHomeSearchStationButtonClicked()
        }
        
        favoriteStationView.tapSchoolSearchStationButton = {[weak self] in
            guard let self else { return }
            
            navigationController?.pushViewController(SchoolSearchStationViewController(), animated: true)
            postSchoolSearchStationButtonClicked()
        }
        
        favoriteStationView.tapSetButton = {[weak self] in
            guard let self else { return }
            
            navigationController?.popViewController(animated: true)
            postSetButtonClicked()
        }
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        favoriteStationView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: Networking
    private func postHomeSearchStationButtonClicked(){
        print("homeSearchStationButton clicked")
    }
    
    private func postSchoolSearchStationButtonClicked(){
        print("schoolSearchStationButton clicked")
    }
    
    private func postSetButtonClicked(){
        print("setButton clicked")
    }
    
    // MARK: NavigationBar
    private func setNavigationBar(){
        navigationItem.title = "자주 가는 역 설정"
    }
    
}
