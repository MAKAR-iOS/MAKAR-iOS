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
        
        configureSubviews()
        makeConstraints()
        setNavigationBar()
        setEditing()
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
        let navigationBar = navigationController?.navigationBar
        navigationBar?.topItem?.backButtonTitle = ""
        navigationBar?.tintColor = .black
    }
    
    // MARK: Keyboard
    func setEditing(){
          let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
          tap.cancelsTouchesInView = false
          view.addGestureRecognizer(tap)
        }
        
        @objc func handleTap() {
            self.view.endEditing(true)
        }
}


