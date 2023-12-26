//
//  HomeView.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class HomeView: BaseView {
    
    // MARK: Constants
    private enum Metric {
        static let buttonHeight = 43
        static let buttonRadius = 18
        static let dividerHeight = 2
    }
    
    // MARK: UI Components
    private let mainTitleText = UILabel().then {
        $0.text = "경로를 설정해주세요"
        $0.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
    }
    
    private let mainRouteView = UILabel().then{
        //TODO: Text ic_arrow 수정 필요
        $0.text = "출발역  ->  도착역"
        $0.textColor = .darkGray
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        $0.backgroundColor = .systemGray6
        $0.clipsToBounds = true
        $0.layer.cornerRadius = CGFloat(Metric.buttonRadius)
    }
    
    private let mainMakarProgress = UIImageView().then{
        $0.image = UIImage(named: "makar_progress")
    }
    
    private let mainDestinationText = UILabel().then{
        $0.text = "MAKAR"
        $0.font = UIFont.systemFont(ofSize: 15, weight: .light)
    }
    
    private let setRouteButton = BaseButton().then {
        $0.setTitle("경로 설정하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .makarBlue
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        $0.layer.cornerRadius = CGFloat(Metric.buttonRadius)
    }
    
    private let mainDivider1 = UIView().then{
        $0.backgroundColor = .divider
    }
    
    private let favoriteRouteListText = UILabel().then{
        $0.text = "즐겨찾는 경로"
        $0.font = UIFont.systemFont(ofSize: 15, weight: .light)
    }
    
    private let mainDivider2 = UIView().then{
        $0.backgroundColor = .divider
    }
    
    private let recentRouteListText = UILabel().then{
        $0.text = "최근 경로"
        $0.font = UIFont.systemFont(ofSize: 15, weight: .light)
    }
    
    
    
    // MARK: Properties
    var tapSetRouteButton: (() -> Void)?
    
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(mainTitleText)
        addSubview(mainRouteView)
        addSubview(mainMakarProgress)
        addSubview(mainDestinationText)
        addSubview(setRouteButton)
        addSubview(mainDivider1)
        addSubview(favoriteRouteListText)
        addSubview(mainDivider2)
        addSubview(recentRouteListText)
        
        setRouteButton.addTarget(self, action: #selector(handleSetRouteButtonClickEvent), for: .touchUpInside)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        mainTitleText.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(10)
            $0.leading.equalToSuperview().inset(20)
        }
        
        mainRouteView.snp.makeConstraints {
            $0.top.equalTo(mainTitleText.snp.bottom).inset(-10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.buttonHeight)
        }
        
        mainMakarProgress.snp.makeConstraints {
            $0.top.equalTo(mainRouteView.snp.bottom).inset(-30)
            $0.leading.trailing.equalToSuperview().inset(50)
        }
        
        mainDestinationText.snp.makeConstraints {
            $0.top.equalTo(mainMakarProgress.snp.bottom).inset(-3)
            $0.trailing.equalToSuperview().inset(70)
        }
        
        setRouteButton.snp.makeConstraints {
            $0.top.equalTo(mainDestinationText.snp.bottom).inset(-30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.buttonHeight)
        }
        
        mainDivider1.snp.makeConstraints {
            $0.top.equalTo(setRouteButton.snp.bottom).inset(-30)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Metric.dividerHeight)
        }
        
        favoriteRouteListText.snp.makeConstraints{
            $0.top.equalTo(mainDivider1.snp.bottom).inset(-15)
            $0.leading.equalToSuperview().inset(20)
        }
        
        mainDivider2.snp.makeConstraints {
            $0.top.equalTo(favoriteRouteListText.snp.bottom).inset(-30)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Metric.dividerHeight)
        }
        
        recentRouteListText.snp.makeConstraints{
            $0.top.equalTo(mainDivider2.snp.bottom).inset(-15)
            $0.leading.equalToSuperview().inset(20)
        }
    }
    
    // MARK: Event
    @objc private func handleSetRouteButtonClickEvent() {
        tapSetRouteButton?()
    }
    
}
