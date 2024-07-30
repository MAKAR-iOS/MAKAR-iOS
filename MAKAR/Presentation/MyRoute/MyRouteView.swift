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
    let myRoute: [Route] = Route.myRoute
    private let dateFormatter = DateFormatter().then {
        $0.locale = Locale(identifier: "ko_kr")
    }

    // MARK: Configuration
    override func configureSubviews() {
        super.configureSubviews()
        self.backgroundColor = .background
        setData(data: myRoute[0])

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
    func setData(data: Route) {
        let startTime = changeDateFormat(date: data.sourceTime)
        let endTime = changeDateFormat(date: data.destinationTime)

        makarLabel.text = "\(data.totalTime)분"
        myRouteTimeLabel.text = "\(startTime) 출발 | \(endTime) 도착"
        makarDetailLabel.text = "\(checkLeftTime(targetDate: data.sourceTime))분 후 막차"
        if (myRouteProgressView.subviews.isEmpty) {
            myRouteProgressView.setData(subRouteList: data.subRouteList)
        }
    }

    private func changeDateFormat(date: Date) -> String {
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }

    private func checkLeftTime(targetDate: Date) -> Int {
        let date = Date()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"

        let currentDate = dateFormatter.date(from: dateFormatter.string(from: date))!
        let targetDate = dateFormatter.date(from: dateFormatter.string(from: targetDate))!
        print("[currentTime] : \(currentDate)")
        return Calendar.current.dateComponents([.minute], from: currentDate, to: targetDate).minute!
    }
}
