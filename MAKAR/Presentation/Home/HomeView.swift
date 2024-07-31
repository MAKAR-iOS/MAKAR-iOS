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
    let mainTitleText = UILabel().then {
        $0.text = "경로를 설정해주세요"
        $0.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
    }

    private let resetRouteButton = BaseButton().then {
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

    private let mainRouteView = UILabel().then {
        $0.text = "출발역   →   도착역"
        $0.textColor = .darkGray
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        $0.backgroundColor = .systemGray6
        $0.clipsToBounds = true
        $0.layer.cornerRadius = CGFloat(Metric.buttonRadius)
    }

    private let mainMakarProgress = UIImageView().then {
        $0.image = MakarImage.makarProgress
    }

    private let mainDestinationText = UILabel().then {
        $0.text = "MAKAR"
        $0.font = UIFont.systemFont(ofSize: 15, weight: .light)
    }

    private let setRouteButton = RouteButton().then {
        $0.setTitle("경로 설정하기", for: .normal)
    }

    private let changeRouteButton = BaseButton().then {
        $0.setTitle("경로 변경하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.layer.cornerRadius = CGFloat(Metric.buttonRadius)
    }

    private let setAlarmButton = RouteButton().then{
        $0.setTitle("막차/하차 알림 설정하기", for: .normal)
    }

    private let mainDivider1 = UIView().then{
        $0.backgroundColor = .divider
    }

    let favoriteRouteListText = UILabel().then{
        $0.text = "즐겨찾는 경로"
        $0.font = UIFont.systemFont(ofSize: 15, weight: .light)
        $0.textColor = .darkGray
    }

    private let editFavoriteRouteButton = BaseButton().then{
        $0.setTitle("편집", for: .normal)
        $0.setTitleColor(.lightGray3, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .light)
    }

    private let mainDivider2 = UIView().then{
        $0.backgroundColor = .divider
    }

    let recentRouteListText = UILabel().then{
        $0.text = "최근 경로"
        $0.font = UIFont.systemFont(ofSize: 15, weight: .light)
        $0.textColor = .darkGray
    }

    let allDeleteRecentRouteButton = BaseButton().then{
        $0.setTitle("전체 삭제", for: .normal)
        $0.setTitleColor(.lightGray3, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .light)
    }

    // MARK: Properties
    var tapResetRouteButton: (() -> Void)?
    var tapSetRouteButton: (() -> Void)?
    var tapChangeRouteButton: (() -> Void)?
    var tapSetAlarmButton: (() -> Void)?
    var tapEditFavoriteRouteButton: (() -> Void)?
    var tapAllDeleteRecentRouteButton: (() -> Void)?

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
        addSubview(editFavoriteRouteButton)
        addSubview(mainDivider2)
        addSubview(recentRouteListText)
        addSubview(allDeleteRecentRouteButton)

        resetRouteButton.addTarget(self, action: #selector(handleResetRouteButtonClickEvent), for: .touchUpInside)
        setRouteButton.addTarget(self, action: #selector(handleSetRouteButtonClickEvent), for: .touchUpInside)
        changeRouteButton.addTarget(self, action: #selector(handleChangeRouteButtonClickEvent), for: .touchUpInside)
        setAlarmButton.addTarget(self, action: #selector(handleSetAlarmButtonClickEvent), for: .touchUpInside)
        editFavoriteRouteButton.addTarget(self, action: #selector(handleEditFavoriteRouteButton), for: .touchUpInside)
        allDeleteRecentRouteButton.addTarget(self, action: #selector(handleAllDeleteRecentRouteButton), for: .touchUpInside)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        mainTitleText.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(10)
            $0.leading.equalToSuperview().inset(20)
        }

        resetRouteButton.snp.makeConstraints {
            $0.centerY.equalTo(mainTitleText)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.resetButtonHeight)
        }

        mainRouteView.snp.makeConstraints {
            $0.top.equalTo(mainTitleText.snp.bottom).inset(-10)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.buttonHeight)
        }

        mainMakarProgress.snp.makeConstraints {
            $0.top.equalTo(mainRouteView.snp.bottom).inset(-30)
            $0.horizontalEdges.equalToSuperview().inset(50)
        }

        mainDestinationText.snp.makeConstraints {
            $0.top.equalTo(mainMakarProgress.snp.bottom).inset(-3)
            $0.centerX.equalTo(mainMakarProgress.snp.trailing).inset(45)
        }

        setRouteButton.snp.makeConstraints {
            $0.top.equalTo(mainDestinationText.snp.bottom).inset(-30)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.buttonHeight)
        }

        changeRouteButton.snp.makeConstraints{
            $0.top.equalTo(mainDestinationText.snp.bottom).inset(-30)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.buttonHeight)
        }
    
        setAlarmButton.snp.makeConstraints{
            $0.top.equalTo(changeRouteButton.snp.bottom).inset(-10)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(Metric.buttonHeight)
        }
    
        mainDivider1.snp.makeConstraints {
            $0.top.equalTo(setRouteButton.snp.bottom).inset(-70)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(Metric.dividerHeight)
        }

        favoriteRouteListText.snp.makeConstraints {
            $0.top.equalTo(mainDivider1.snp.bottom).inset(-15)
            $0.leading.equalToSuperview().inset(20)
        }

        editFavoriteRouteButton.snp.makeConstraints {
            $0.top.equalTo(favoriteRouteListText.snp.top)
            $0.trailing.equalToSuperview().inset(20)
        }

        mainDivider2.snp.makeConstraints {
            $0.top.equalTo(favoriteRouteListText.snp.bottom).inset(-130)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(Metric.dividerHeight)
        }
    
        recentRouteListText.snp.makeConstraints {
            $0.top.equalTo(mainDivider2.snp.bottom).inset(-15)
            $0.leading.equalToSuperview().inset(20)
        }

        allDeleteRecentRouteButton.snp.makeConstraints {
            $0.top.equalTo(recentRouteListText.snp.top)
            $0.trailing.equalToSuperview().inset(20)
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

    @objc private func handleEditFavoriteRouteButton() {
        tapEditFavoriteRouteButton?()
    }

    @objc private func handleAllDeleteRecentRouteButton() {
        tapAllDeleteRecentRouteButton?()
    }

    // MARK: ChangeComponent
    func changeComponentRouteSet(source: String, destination: String) {
        mainRouteView.text = "\(source)   →   \(destination)"
        resetRouteButton.isHidden = false
        setRouteButton.isHidden = true
        changeRouteButton.isHidden = false
        setAlarmButton.isHidden = false
    }

    func changeComponentRouteUnset() {
        mainTitleText.text = "경로를 설정해주세요"
        mainRouteView.text = "출발역   →   도착역"
        resetRouteButton.isHidden = true
        setRouteButton.isHidden = false
        changeRouteButton.isHidden = true
        setAlarmButton.isHidden = true
    }

    func changeMainDestinationText(destinationText: String) {
        mainDestinationText.text = destinationText
    }
}
