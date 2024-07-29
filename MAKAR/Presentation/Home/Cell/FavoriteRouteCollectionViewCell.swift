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
    }
    
    // MARK: UI Components
    let lineNumImage = LineNumImage()

    private var sourceLineNumImageView = UIImageView()
        
    var sourceText = UILabel().then{
        $0.font = .systemFont(ofSize: 13, weight: .light)
        $0.sizeToFit()
    }
    private var moreRightLabel = UILabel().then{
        $0.text = ">"
        $0.font = .systemFont(ofSize: 13, weight: .light)
        $0.sizeToFit()
    }
    private var destinationLineNumImageView = UIImageView()
    
    var destinationText = UILabel().then{
        $0.font = .systemFont(ofSize: 13, weight: .light)
        $0.sizeToFit()
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
        self.layer.borderColor = UIColor.lightGray5.cgColor
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
        }
        
        moreRightLabel.snp.makeConstraints{
            $0.top.equalTo(sourceText.snp.bottom).inset(-12)
            $0.leading.equalToSuperview().inset(10)
        }
        
        destinationLineNumImageView.snp.makeConstraints{
            $0.centerY.equalTo(moreRightLabel.snp.centerY)
            $0.leading.equalTo(moreRightLabel.snp.trailing).inset(-3)
            $0.width.height.equalTo(Metric.lineNumSize)
        }
        
        destinationText.snp.makeConstraints{
            $0.centerY.equalTo(moreRightLabel.snp.centerY)
            $0.leading.equalTo(destinationLineNumImageView.snp.trailing).inset(-3)
        }
    }
    
    func setData(data : Route) {
        lineNumImage.addLineNum()

        sourceText.text = data.sourceStation.stationName
        destinationText.text = data.destinationStation.stationName
        
        //출발역 호선 이미지
        if let sourceLineImg = lineNumImage.lineNumMap[data.sourceStation.lineNum] {
            sourceLineNumImageView.image =  sourceLineImg
        } else {
            sourceLineNumImageView.image = MakarImage.line0
        }
        
        //도착역 호선 이미지
        if let destinationLineImg = lineNumImage.lineNumMap[data.destinationStation.lineNum] {
            destinationLineNumImageView.image = destinationLineImg
        } else {
            destinationLineNumImageView.image = MakarImage.line0
        }
     }
}
