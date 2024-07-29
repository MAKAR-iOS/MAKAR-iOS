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
        viewTransition()
        setNavigationItem()
        setEditing()
        view.backgroundColor = .background
    }
    
    // MARK: Configuration
    func configureSubviews() {
        
    }
    
    // MARK: Layout
    func makeConstraints() {
    }
    
    // MARK: View Transition
    func viewTransition() {
    }
    
    // MARK: Set NavigationItem
    func setNavigationItem() {
    }
    
    // MARK: Keyboard
    func setEditing() {
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        self.view.endEditing(true)
    }

    // MARK: Alert
    func presentAlert(
        title: String,
        message: String?,
        cancelButton: String,
        style: UIAlertAction.Style,
        handler: ((UIAlertAction) -> Void)?
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        let cancelButton = UIAlertAction(
            title: cancelButton,
            style: .default,
            handler: handler)

        alertController.addAction(cancelButton)

        present(alertController, animated: true)
    }
}


