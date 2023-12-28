//
//  BaseViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/20.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBackButton()
        configureSubviews()
        makeConstraints()
        setNavigationBar()
        view.backgroundColor = .white
    }
    
    // MARK: Configuration
    func configureSubviews() {
        
    }
    
    // MARK: Layout
    func makeConstraints() {
    }
    
    // MARK: NavigationBar
    func setNavigationBar(){
    }
}
