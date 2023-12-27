//
//  NavigationBarExtension.swift
//  MAKAR
//
//  Created by 김다은 on 12/27/23.
//

import UIKit

extension BaseViewController{
    
    func setNavigationBackButton(){
        let navigationBar = navigationController?.navigationBar

        navigationBar?.topItem?.backButtonTitle = ""
        navigationBar?.tintColor = .black
        
//        navigationBar?.setBackgroundImage(UIImage(), for: .default)
//        navigationBar?.shadowImage = UIImage()
    }
    
}
