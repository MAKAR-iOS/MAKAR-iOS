//
//  SearchRouteProgressView.swift
//  MAKAR
//
//  Created by 김다은 on 1/19/24.
//

import UIKit
class SearchRouteProgressView : UIStackView {
    
    // MARK: Constants
    private enum Metric {
        static let selfHeight = 20
        static let radius = 10
    }
    
    // MARK: UI Components
    let lineNumColor = LineNumColor()
    
    // MARK: Init
    init(){
        super.init(frame: .infinite)
        
        configure()
        makeConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Configuration
    func configure(){
        backgroundColor = .background
        layer.cornerRadius = CGFloat(Metric.radius)
        axis = .horizontal
        distribution = .fillEqually
    }
            
    // MARK: Layout
    func makeConstraints() {
        self.snp.makeConstraints{
            $0.height.equalTo(Metric.selfHeight)
        }
    }
    
    func setData(subRouteList : [SubRoute]){
        lineNumColor.addLineNum()
        
        for subroute in subRouteList {
            let lineNum = subroute.lineNum
            let totalTime = subroute.sectionTime
            let transferTime = subroute.transferTime
            
            let lineProgressView = progressView(color: lineNumColor.lineNumColorMap[lineNum]!, text: "\(totalTime)분")
            self.addArrangedSubview(lineProgressView)
            
            if transferTime != 0{
                let transferInfoView = progressView(color: .divider, text: "\(transferTime)분")
                self.addArrangedSubview(transferInfoView)
            }
        }
    }
}
