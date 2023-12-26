//
//  SearchRouteViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class SearchRouteViewController : BaseViewController {
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        setNavigationBar()
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
    }
    
    // MARK: NavigationBar
    private func setNavigationBar(){
        setNavigationBackButton()
        navigationItem.title = "경로 설정하기"
    }
    
}
