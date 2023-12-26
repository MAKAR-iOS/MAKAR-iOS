//
//  HomeViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class HomeViewController: BaseViewController {
    
    // MARK: UI Components
    private let homeView = HomeView()
    
    // MARK: Environment


    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .background
        setNavigationBar()
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        view.addSubview(homeView)
        
        homeView.tapSetRouteButton = {[weak self] in
            guard let self else { return }
    
            self.navigationController?.pushViewController(SearchRouteViewController(), animated: true)
            postSetRouteButtonClicked()
        }
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        homeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: Networking
    private func postSetRouteButtonClicked() {
        print("setRouteButton clicked")
    }
    
    private func postMapButtonClicked(){
        print("mapButton clicked")
    }
}


extension HomeViewController {
    
    // MARK: NavigationBar
    private func setNavigationBar(){
        //TODO: NavigationBar MAKAR icon custom 필요
        
        navigationItem.title = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_map"), style: .plain, target: self, action: #selector(handleMapButtonClickEvent))
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "logo_makar"), style: .plain, target: nil, action: nil)
    }
    
    @objc private func handleMapButtonClickEvent(){
        postMapButtonClicked()
    }
    
}
