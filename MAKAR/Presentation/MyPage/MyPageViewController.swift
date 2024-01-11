//
//  MyPageViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class MyPageViewController: BaseViewController {
    
    // MARK: Constants
    private enum Metric {
        static let myPageViewHeight = 70
    }

    // MARK: UI Components
    private let myPageView = MyPageView()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
    }
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        
        view.addSubview(myPageView)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        myPageView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Metric.myPageViewHeight)
        }
    }
    
    // MARK: NavigationBar
    override func setNavigationBar(){
        super.setNavigationBar()
        navigationItem.title = "마이페이지"
    }
    
}

extension MyPageViewController {
    private func showLogoutAlert(){
        let logoutAlert = UIAlertController(title: "로그아웃하시겠어요?", message: "", preferredStyle: .alert)
        logoutAlert.addAction( UIAlertAction(title: "로그아웃하기", style: .destructive, handler: {_ in
           
        }))
        logoutAlert.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(logoutAlert, animated: true)
    }
    
    private func showWithdrawalAlert(){
        let withdrawalAlert = UIAlertController(title: "정말 탈퇴하시겠어요?", message: "이 동작은 취소할 수 없어요", preferredStyle: .alert)
        withdrawalAlert.addAction( UIAlertAction(title: "탈퇴하기", style: .destructive, handler: {_ in
           
        }))
        withdrawalAlert.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(withdrawalAlert, animated: true)
    }
}
