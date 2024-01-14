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
        static let lineNumSize = 16
        static let moreLabelSize = 12
        static let deleteButtonSize = 20
    }
    
    // MARK: UI Components
    let lineNumImage = LineNumImage()
    private let favoriteRouteStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 5
        $0.distribution = .equalSpacing
        $0.alignment = .center
    }

    private var sourceLineNumImageView = UIImageView()
        
    private var sourceText = UILabel().then{
        $0.font = .systemFont(ofSize: 14, weight: .light)
    }
    private var moreRightLabel = UILabel().then{
        $0.text = ">"
        $0.font = .systemFont(ofSize: 14, weight: .light)
    }
    private var destinationLineNumImageView = UIImageView()
    
    private var destinationText = UILabel().then{
        $0.font = .systemFont(ofSize: 14, weight: .light)
    }
    
    private var deleteRecentRouteButton = UIButton().then{
        $0.setImage(MakarButton.deleteButton, for: .normal)
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
        addSubview(favoriteRouteStackView)
        favoriteRouteStackView.addArrangedSubview(sourceLineNumImageView)
        favoriteRouteStackView.addArrangedSubview(sourceText)
        favoriteRouteStackView.addArrangedSubview(moreRightLabel)
        favoriteRouteStackView.addArrangedSubview(destinationLineNumImageView)
        favoriteRouteStackView.addArrangedSubview(destinationText)
        addSubview(deleteRecentRouteButton)
    }
        
    // MARK: Layout
    func makeConstraints() {
        deleteRecentRouteButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
            $0.height.width.equalTo(Metric.deleteButtonSize)
        }
        
        favoriteRouteStackView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.lessThanOrEqualTo(deleteRecentRouteButton.snp.leading)
        }
    }
    
    func setData(data : RouteData) {
        //TODO: data 설정 수정
        lineNumImage.addLineNum()

        sourceText.text = data.sourceText
        destinationText.text = data.destinationText
        
        //출발역 호선 이미지
        if let sourceLineImg = lineNumImage.lineNumMap[data.sourceLine] {
            sourceLineNumImageView.image =  sourceLineImg
        } else {
            sourceLineNumImageView.image = MakarImage.line0
        }
        
        //도착역 호선 이미지
        if let destinationLineImg = lineNumImage.lineNumMap[data.destinationLine] {
            destinationLineNumImageView.image = destinationLineImg
        } else {
            destinationLineNumImageView.image = MakarImage.line0
        }
    }
}

