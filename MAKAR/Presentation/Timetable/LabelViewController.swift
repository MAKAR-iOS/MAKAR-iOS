//
//  LabelViewController.swift
//  MAKAR
//
//  Created by 박지윤 on 1/23/24.
//

import UIKit

final class LabelViewController: UIViewController {
    private let label = UILabel().then {
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 20, weight: .regular)
        $0.textColor = .lightGray
        $0.textAlignment = .center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func setupTitle(_ text: String) {
        label.text = text
    }
}
