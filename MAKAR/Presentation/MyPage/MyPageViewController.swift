//
//  MyPageViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class MyPageViewController: BaseViewController {

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
