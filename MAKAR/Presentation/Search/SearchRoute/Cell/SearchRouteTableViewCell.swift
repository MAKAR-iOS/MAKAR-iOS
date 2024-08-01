//
//  SearchRouteTableViewCell.swift
//  MAKAR
//
//  Created by 김다은 on 1/18/24.
//

import UIKit
class SearchRouteTableViewCell : UITableViewCell {
    
    // MARK: Constants
    private enum Metric {
        static let dividerHeight = 6
        static let dividerWidth = 2
    }
    
    private let dateFormatter = DateFormatter().then {
        $0.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
        $0.locale = Locale(identifier: "en_US_POSIX")
    }
    
    // MARK: UI Components
    let lineNumImage = LineNumImage()
    
    let totalTimeLabel = UILabel().then { //탑승 시간
        $0.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        $0.sizeToFit()
    }
    
    let routeTimeLabel = UILabel().then { //출발, 도착 시간
        $0.font = UIFont.systemFont(ofSize: 14, weight: .light)
        $0.sizeToFit()
    }
    
    let favoriteRouteButton = BaseButton().then {
        $0.setImage(MakarButton.starButton, for: .normal)
    }
    
    let leftTimeLabel = UILabel().then { //남은 시간
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        $0.sizeToFit()
    }
    
    let routeProgressView = SearchRouteProgressView()
    
    let routeStackView = UIStackView().then { //경로
        $0.axis = .vertical
        $0.spacing = 12
        $0.distribution = .equalSpacing
        $0.alignment = .leading
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
    func configure() {
        self.backgroundColor = .background
    }
    
    func configureSubviews() {
        contentView.addSubview(totalTimeLabel)
        contentView.addSubview(routeTimeLabel)
        contentView.addSubview(leftTimeLabel)
        contentView.addSubview(routeProgressView)
        contentView.addSubview(routeStackView)
        contentView.addSubview(favoriteRouteButton)

        favoriteRouteButton.addTarget(self, action: #selector(handleFavoriteRecentRouteButton), for: .touchUpInside)
    }

    // MARK: Properties
    var tapFavoriteRouteButton: (() -> Void)?

    // MARK: Layout
    func makeConstraints() {
        totalTimeLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
        }

        routeTimeLabel.snp.makeConstraints {
            $0.centerY.equalTo(totalTimeLabel.snp.centerY).offset(2)
            $0.leading.equalTo(totalTimeLabel.snp.trailing).offset(8)
        }

        favoriteRouteButton.snp.makeConstraints {
            $0.centerY.equalTo(totalTimeLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.width.equalTo(20)
        }

        leftTimeLabel.snp.makeConstraints {
            $0.top.equalTo(totalTimeLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
        }

        routeProgressView.snp.makeConstraints {
            $0.top.equalTo(leftTimeLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        routeStackView.snp.makeConstraints {
            $0.top.equalTo(routeProgressView.snp.bottom).offset(17)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(17)
        }
    }
}

extension SearchRouteTableViewCell {
    func setData(data: RouteDTO) {
        lineNumImage.addLineNum()
        let startTime = changeDateFormat(date: data.sourceTime)
        let endTime = changeDateFormat(date: data.destinationTime)

        totalTimeLabel.text = "\(data.totalTime)분"
        routeTimeLabel.text = "\(startTime) 출발 | \(endTime) 도착"
        leftTimeLabel.text = "\(checkLeftTime(targetDate: data.sourceTime))분 후 막차"

        if !(routeProgressView.subviews.isEmpty) {
            for subview in routeProgressView.subviews {
                subview.removeFromSuperview()
            }
        }

        if !(routeStackView.subviews.isEmpty) {
            for subview in routeStackView.subviews {
                subview.removeFromSuperview()
            }
        }

        routeProgressView.setData(subRouteList: data.subRouteDtoList)

        //출발역
        let routeLabel = SubRouteTextView(
            lineName: data.sourceStationName,
            lineNum: data.sourceLineNum)
        routeStackView.addArrangedSubview(routeLabel)
        //중간역, 도착역
        for route in data.subRouteDtoList {
            let routeLabel = SubRouteTextView(lineName: route.toStationName, lineNum: route.lineNum)
            routeStackView.addArrangedSubview(routeLabel)
        }
    }

    //열차 출발, 도착 시간 format 지정
    private func changeDateFormat(date: String) -> String {
        let outputDateFormatter = DateFormatter().then{
            $0.dateFormat = "HH:mm"
            $0.locale = Locale(identifier: "ko_KR")
        }

        let date = convertStringToDate(targetDateString: date)
        return outputDateFormatter.string(from: date)
    }

    //현재 시간과 막차 시간 비교 후 남은 시간 반환
    private func checkLeftTime(targetDate: String) -> Int {
        let currentDate = Date()
        let targetDate = convertStringToDate(targetDateString: targetDate)
        return Calendar.current.dateComponents([.minute], from: currentDate, to: targetDate).minute!
    }

    private func convertStringToDate(targetDateString: String) -> Date {
        let adjustedDateString = targetDateString.replacingOccurrences(of: "KST", with: "+0900")
        return dateFormatter.date(from: adjustedDateString)!
    }

    // MARK: Event
    @objc func handleFavoriteRecentRouteButton() {
        tapFavoriteRouteButton?()
    }
}
