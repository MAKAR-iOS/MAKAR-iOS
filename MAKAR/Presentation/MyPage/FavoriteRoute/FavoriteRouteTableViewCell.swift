//
//  FavoriteRouteCell.swift
//  MAKAR
//
//  Created by 김다은 on 1/11/24.
//

import UIKit
class FavoriteRouteTableViewCell : UITableViewCell {
    
    // MARK: Constants
    private enum Metric {
    }
    
    // MARK: UI Components
        // TODO: UI수정
    private var tempLabel = UILabel().then{
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.textColor = .darkGray
    }
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configuration
    func configureSubviews() {
        addSubview(tempLabel)
    }
        
    // MARK: Layout
    func makeConstraints() {
        tempLabel.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setData(data : RouteData) {
        tempLabel.text = "\(data.sourceText) -> \(data.destinationText)"
    }
}

