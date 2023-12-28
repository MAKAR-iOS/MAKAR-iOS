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
        static let dividerHeight = 4
        static let resetButtonHeight = 26
    }
    
    // MARK: UI Components
    private let mainTitleText = UILabel().then {
        $0.text = "경로를 설정해주세요"
        $0.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
    }
    
    private let resetRouteButton = BaseButton().then{
        var title = AttributedString("경로 취소")
        title.font = UIFont.systemFont(ofSize: 11, weight: .medium)

        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .white
        config.cornerStyle = .capsule
        config.attributedTitle = title
        config.baseForegroundColor = .black
        config.background.strokeColor = .black
        config.background.strokeWidth = 0.7
        $0.configuration = config
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
        $0.image = MakarImage.makarProgress
    }
    
    private let mainDestinationText = UILabel().then{
        $0.text = "MAKAR"
        $0.font = UIFont.systemFont(ofSize: 15, weight: .light)
    }
    
    private let setRouteButton = BaseRouteButton().then {
        $0.setTitle("경로 설정하기", for: .normal)
    }
    
    private let changeRouteButton = BaseButton().then{
        $0.setTitle("경로 변경하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.layer.cornerRadius = CGFloat(Metric.buttonRadius)
    }
    
    private let setAlarmButton = BaseRouteButton().then{
        $0.setTitle("막차/하차 알림 설정하기", for: .normal)
    }
    
    private let mainDivider1 = UIView().then{
        $0.backgroundColor = .divider
    }
    
    private let favoriteRouteListText = UILabel().then{
        $0.text = "즐겨찾는 경로"
        $0.font = UIFont.systemFont(ofSize: 15, weight: .light)
        $0.textColor = .darkgray
    }
    
    private let mainDivider2 = UIView().then{
        $0.backgroundColor = .divider
    }
    
    private let recentRouteListText = UILabel().then{
        $0.text = "최근 경로"
        $0.font = UIFont.systemFont(ofSize: 15, weight: .light)
        $0.textColor = .darkgray
    }
    
    // MARK: Properties
    var tapResetRouteButton: (() -> Void)?
    var tapSetRouteButton: (() -> Void)?
    var tapChangeRouteButton: (() -> Void)?
    var tapSetAlarmButton: (() -> Void)?
    
    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()

        addSubview(mainTitleText)
        addSubview(resetRouteButton)
        addSubview(mainRouteView)
        addSubview(mainMakarProgress)
        addSubview(mainDestinationText)
        addSubview(setRouteButton)
        addSubview(changeRouteButton)
        addSubview(setAlarmButton)
        addSubview(mainDivider1)
        addSubview(favoriteRouteListText)
        addSubview(mainDivider2)
        addSubview(recentRouteListText)
        
        resetRouteButton.addTarget(self, action: #selector(handleResetRouteButtonClickEvent), for: .touchUpInside)
        setRouteButton.addTarget(self, action: #selector(handleSetRouteButtonClickEvent), for: .touchUpInside)
        changeRouteButton.addTarget(self, action: #selector(handleChangeRouteButtonClickEvent), for: .touchUpInside)
        setAlarmButton.addTarget(self, action: #selector(handleSetAlarmButtonClickEvent), for: .touchUpInside)
    }
    
    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()
        
        mainTitleText.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(10)
            $0.leading.equalToSuperview().inset(20)
        }
        
        resetRouteButton.snp.makeConstraints{
            $0.centerY.equalTo(mainTitleText)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.resetButtonHeight)
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
            $0.centerX.equalTo(mainMakarProgress.snp.trailing).inset(45)
        }
        
        setRouteButton.snp.makeConstraints {
            $0.top.equalTo(mainDestinationText.snp.bottom).inset(-30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.buttonHeight)
        }
        
        changeRouteButton.snp.makeConstraints{
            $0.top.equalTo(mainDestinationText.snp.bottom).inset(-30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.buttonHeight)
        }
        
        setAlarmButton.snp.makeConstraints{
            $0.top.equalTo(changeRouteButton.snp.bottom).inset(-10)
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
    @objc private func handleResetRouteButtonClickEvent() {
        tapResetRouteButton?()
    }
    
    @objc private func handleSetRouteButtonClickEvent() {
        tapSetRouteButton?()
    }
    
    @objc private func handleChangeRouteButtonClickEvent() {
        tapChangeRouteButton?()
    }
    
    @objc private func handleSetAlarmButtonClickEvent() {
        tapSetAlarmButton?()
    }
    
    // MARK: ChangeComponent
    func changeComponentRouteSet(){
        mainTitleText.text = "막차까지 12분 남았어요!"
        mainRouteView.text = "Source   ->  Destination"
        mainDestinationText.text = "Destination"
        resetRouteButton.isHidden = false
        setRouteButton.isHidden = true
        changeRouteButton.isHidden = false
        setAlarmButton.isHidden = false
        mainDivider1.isHidden = true
        mainDivider2.isHidden = true
        favoriteRouteListText.isHidden = true
        recentRouteListText.isHidden = true
    }
    
    func changeComponentRouteUnset(){
        mainTitleText.text = "경로를 설정해주세요"
        mainRouteView.text = "출발역   ->  도착역"
        mainDestinationText.text = "MAKAR"
        resetRouteButton.isHidden = true
        setRouteButton.isHidden = false
        changeRouteButton.isHidden = true
        setAlarmButton.isHidden = true
        mainDivider1.isHidden = false
        mainDivider2.isHidden = false
        favoriteRouteListText.isHidden = false
        recentRouteListText.isHidden = false
    }
}
