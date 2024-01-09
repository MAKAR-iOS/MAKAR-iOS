//
//  FavoriteRouteCollectionViewCell.swift
//  MAKAR
//
//  Created by 김다은 on 1/9/24.
//

import UIKit
class FavoriteRouteCollectionViewCell : UICollectionViewCell {
    // MARK: Constants
    private enum Metric {
        static let lineNumSize = 15
        static let moreLabelSize = 12
    }
    
    // MARK: UI Components
    let lineNumImage = LineNumImage()

    private var sourceLineNumImageView = UIImageView()
        
    private var sourceText = UILabel().then{
        $0.font = .systemFont(ofSize: 13, weight: .light)
    }
    private var moreRightLabel = UILabel().then{
        $0.text = ">"
        $0.font = .systemFont(ofSize: 13, weight: .light)
    }
    private var destinationLineNumImageView = UIImageView()
    
    private var destinationText = UILabel().then{
        $0.font = .systemFont(ofSize: 13, weight: .light)
    }
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        configureSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configuration
    func configure(){
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightgray4.cgColor
    }
    
    func configureSubviews() {
        addSubview(sourceLineNumImageView)
        addSubview(sourceText)
        addSubview(moreRightLabel)
        addSubview(destinationLineNumImageView)
        addSubview(destinationText)
    }
    
    // MARK: Layout
    func makeConstraints() {
        sourceLineNumImageView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(25)
            $0.leading.equalToSuperview().inset(10)
            $0.width.height.equalTo(Metric.lineNumSize)
        }
        
        sourceText.snp.makeConstraints{
            $0.top.equalToSuperview().inset(25)
            $0.leading.equalTo(sourceLineNumImageView.snp.trailing).inset(-3)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        moreRightLabel.snp.makeConstraints{
            $0.top.equalTo(sourceText.snp.bottom).inset(-12)
            $0.leading.equalToSuperview().inset(10)
            $0.width.height.equalTo(Metric.moreLabelSize)
        }
        
        destinationLineNumImageView.snp.makeConstraints{
            $0.centerY.equalTo(moreRightLabel.snp.centerY)
            $0.leading.equalTo(moreRightLabel.snp.trailing).inset(-1)
            $0.width.height.equalTo(Metric.lineNumSize)
        }
        
        destinationText.snp.makeConstraints{
            $0.centerY.equalTo(moreRightLabel.snp.centerY)
            $0.leading.equalTo(destinationLineNumImageView.snp.trailing).inset(-3)
            $0.trailing.equalToSuperview().inset(10)
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