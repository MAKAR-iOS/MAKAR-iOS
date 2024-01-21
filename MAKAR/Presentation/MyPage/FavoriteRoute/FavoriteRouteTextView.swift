//
//  FavoriteRouteTextView.swift
//  MAKAR
//
//  Created by 김다은 on 1/21/24.
//

import UIKit
class FavoriteRouteTextView : UIView{
    
    // MARK: Constants
    private enum Metric {
        static let lineNumSize = 17
        static let selfHeight = 22
    }
    
    // MARK: UI Components
    let lineNumImage = LineNumImage()

    private var lineNumImageView = UIImageView()
        
    private var lineNameLabel = UILabel().then{
        $0.font = .systemFont(ofSize: 14, weight: .light)
        $0.sizeToFit()
    }
    
    // MARK: Init
    init(lineName : String, lineNum : String){
        super.init(frame: .infinite)
        
        setData(lineName: lineName, lineNum: lineNum)
        configureSubviews()
        configure()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configuration
    func configure(){
        self.snp.makeConstraints{
            $0.height.equalTo(Metric.selfHeight)
            //view의 width 임의 지정
            $0.trailing.equalTo(lineNameLabel.snp.trailing)
        }
    }
    
    func configureSubviews() {
        addSubview(lineNumImageView)
        addSubview(lineNameLabel)
    }
            
    // MARK: Layout
    func makeConstraints() {
        lineNumImageView.snp.makeConstraints{
            $0.centerY.leading.equalToSuperview()
            $0.height.width.equalTo(Metric.lineNumSize)
        }
        
        lineNameLabel.snp.makeConstraints{
            $0.centerY.equalTo(lineNumImageView.snp.centerY)
            $0.leading.equalTo(lineNumImageView.snp.trailing).inset(-5)
        }
    }
    
    func setData(lineName : String, lineNum : String){
        lineNumImage.addLineNum()

        lineNameLabel.text = lineName
        
        if let lineImg = lineNumImage.lineNumMap[lineNum] {
            lineNumImageView.image =  lineImg
        } else {
            lineNumImageView.image = MakarImage.line0
        }
    }
}
