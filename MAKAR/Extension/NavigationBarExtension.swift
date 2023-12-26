//
//  NavigationBarExtension.swift
//  MAKAR
//
//  Created by 김다은 on 12/27/23.
//

import UIKit

extension BaseViewController{
    
    func setNavigationBackButton(){
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .black
    }
    
}
