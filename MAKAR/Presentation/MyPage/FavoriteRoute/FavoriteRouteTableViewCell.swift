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
    
    private var deleteRecentRouteButton = UIButton().then{
        $0.setImage(MakarButton.deleteButton, for: .normal)
    }
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        configureSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configuration
    func configure(){
        self.backgroundColor = .background
    }
    
    func configureSubviews() {
        addSubview(favoriteRouteStackView)
        addSubview(deleteRecentRouteButton)
        
        deleteRecentRouteButton.addTarget(self, action: #selector(handleDeleteRecentRouteButton), for: .touchUpInside)
    }
    
    // MARK: Properties
    var tapDeleteRecentRouteButton: (() -> Void)?
        
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
    
    func setData(data : Route) {
        lineNumImage.addLineNum()
        
        if(favoriteRouteStackView.subviews.isEmpty){
            //출발역
            let routeLabel = FavoriteRouteTextView(lineName: data.sourceStation.stationName, lineNum: data.sourceStation.lineNum)
            favoriteRouteStackView.addArrangedSubview(routeLabel)
            
            //중간역, 도착역
            for route in data.subRouteList {
                
                let moreRightLabel = UILabel().then{
                    $0.text = ">"
                    $0.font = .systemFont(ofSize: 14, weight: .light)
                }
                favoriteRouteStackView.addArrangedSubview(moreRightLabel)
                
                let routeLabel = FavoriteRouteTextView(lineName: route.toStationName, lineNum: route.lineNum)
                favoriteRouteStackView.addArrangedSubview(routeLabel)
            }
        }
    }
    
    // MARK: Event
    @objc func handleDeleteRecentRouteButton(){
        tapDeleteRecentRouteButton?()
    }
}

