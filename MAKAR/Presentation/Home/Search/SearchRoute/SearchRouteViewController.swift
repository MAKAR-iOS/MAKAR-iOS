//
//  SearchRouteViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class SearchRouteViewController : BaseViewController {
    
    // MARK: UI Components
    private let searchRouteView = SearchRouteView()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        setNavigationBar()
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        
        view.addSubview(searchRouteView)
        
        searchRouteView.tapSwapStationButton = {[weak self] in
            guard let self else { return }
            postSwapStationButtonClicked()
        }
        
        searchRouteView.tapSourceSearchBar = {[weak self] in
            guard let self else { return }
            
            self.navigationController?.pushViewController(SourceSearchStationViewController(), animated: true)
            postSourceSearchBarClicked()
        }

        searchRouteView.tapDestinationSearchBar = {[weak self] in
            guard let self else { return }
            
            self.navigationController?.pushViewController(DestinationSearchStationViewController(), animated: true)
            postDestinationSearchBarClicked()
        }
        
        searchRouteView.tapSearchRouteButton = {[weak self] in
            guard let self else { return }
            postSearchRouteButtonClicked()
        }
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        // TODO: Layout 수정
        searchRouteView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: Networking
    private func postSwapStationButtonClicked(){
        print("swapStationButton clicked")
    }
    
    private func postSourceSearchBarClicked(){
        print("sourceSearchBar clicked")
    }
    
    private func postDestinationSearchBarClicked(){
        print("destinationSearchBar clicked")
    }
    
    private func postSearchRouteButtonClicked(){
        print("searchRouteButton clicked")
    }
    
    // MARK: NavigationBar
    private func setNavigationBar(){
        navigationItem.title = "경로 설정하기"
    }
    
}
