//
//  MyRouteView.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/25.
//

import UIKit

class MyRouteView: BaseView {
    // MARK: UI Components
    private let makarLabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    }

    private let myRouteTimeLabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    }

    private let makarDetailLabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    private let myRouteProgressView = SearchRouteProgressView()
    private let dividerView = DividerView(dividerType: .thick)

    // MARK: Properties
    var myRoute: RouteDTO?

    private let dateFormatter = DateFormatter().then {
        $0.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
        $0.locale = Locale(identifier: "en_US_POSIX")
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        self.backgroundColor = .background

        addSubview(makarLabel)
        addSubview(myRouteTimeLabel)
        addSubview(makarDetailLabel)
        addSubview(myRouteProgressView)
        addSubview(dividerView)
    }

    // MARK: Layout
    override func makeConstraints() {
        super.makeConstraints()

        makarLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(160)
            $0.leading.equalToSuperview().inset(20)
        }

        myRouteTimeLabel.snp.makeConstraints {
            $0.bottom.equalTo(makarLabel.snp.bottom)
            $0.leading.equalTo(makarLabel.snp.trailing).inset(-9)
        }

        makarDetailLabel.snp.makeConstraints {
            $0.top.equalTo(makarLabel.snp.bottom).offset(7)
            $0.leading.equalTo(makarLabel.snp.leading)
        }

        myRouteProgressView.snp.makeConstraints {
            $0.top.equalTo(makarDetailLabel.snp.bottom).offset(15)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        dividerView.snp.makeConstraints {
            $0.top.equalTo(myRouteProgressView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(8)
        }
    }
}

extension MyRouteView {
    func setData(data: RouteDTO?) {
        guard let data = data else { return }

        let startTime = changeDateFormat(date: data.sourceTime)
        let endTime = changeDateFormat(date: data.destinationTime)

        makarLabel.text = "\(data.totalTime)분"
        myRouteTimeLabel.text = "\(startTime) 출발 | \(endTime) 도착"
        makarDetailLabel.text = "\(checkLeftTime(targetDate: data.sourceTime))분 후 막차"
        if (myRouteProgressView.subviews.isEmpty) {
            myRouteProgressView.setData(subRouteList: data.subRouteDtoList)
        }
    }

    private func changeDateFormat(date: String) -> String {
        let outputDateFormatter = DateFormatter().then{
            $0.dateFormat = "HH:mm"
            $0.locale = Locale(identifier: "ko_kr")
        }

        let date = convertStringToDate(targetDateString: date)
        return outputDateFormatter.string(from: date)
    }

    private func checkLeftTime(targetDate: String) -> Int {
        let currentDate = Date()
        let targetDate = convertStringToDate(targetDateString: targetDate)
        return Calendar.current.dateComponents([.minute], from: currentDate, to: targetDate).minute!
    }

    private func convertStringToDate(targetDateString: String) -> Date {
        let adjustedDateString = targetDateString.replacingOccurrences(of: "KST", with: "+0900")
                                                .replacingOccurrences(of: "UTC", with: "+0900")
        return dateFormatter.date(from: adjustedDateString)!
    }
}
