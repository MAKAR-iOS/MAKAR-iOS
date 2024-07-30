//
//  RouteData.swift
//  MAKAR
//
//  Created by 김다은 on 1/10/24.
//

import UIKit
struct Route {
    let sourceStation : Station //출발역
    let destinationStation : Station //도착역
    let sourceTime : Date //막차 시간
    let destinationTime : Date //하차 시간
    let totalTime : Int //탑승 시간
    let transferCount : Int
    let date : String //경로 설정한 날짜
    let subRouteList : [SubRoute]
}

extension Route {
    static let favoriteRouteList : [Route] = [
        Route(sourceStation: Station(stationName: "강남역", lineNum: "2호선"),
                  destinationStation: Station(stationName: "숭실대입구역", lineNum: "7호선"),
                  sourceTime: Date(), destinationTime: Date(), totalTime: 40, transferCount: 1, date: "",
                  subRouteList: [
                    SubRoute(fromStationName: "강남역", toStationName: "대림역", lineNum: "2호선", sectionTime: 24, transferTime: 4),
                  SubRoute(fromStationName: "대림역", toStationName: "숭실대입구역", lineNum: "7호선", sectionTime: 12, transferTime: 5)]),
        Route(sourceStation: Station(stationName: "홍대입구역", lineNum: "2호선"),
                  destinationStation: Station(stationName: "신촌역", lineNum: "2호선"),
                  sourceTime: Date(), destinationTime: Date(), totalTime: 20, transferCount: 0, date: "",
                  subRouteList: [SubRoute(fromStationName: "홍대입구역", toStationName: "신촌역", lineNum: "2호선", sectionTime: 2, transferTime: 0)]),
        Route(sourceStation: Station(stationName: "이태원역", lineNum: "6호선"),
                  destinationStation: Station(stationName: "부평역", lineNum: "1호선"),
                  sourceTime: Date(), destinationTime: Date(), totalTime: 73, transferCount: 1, date: "",
                  subRouteList: [SubRoute(fromStationName: "이태원역", toStationName: "동묘앞역", lineNum: "6호선", sectionTime: 10, transferTime: 2),
                            SubRoute(fromStationName: "동묘앞역", toStationName: "부평역", lineNum: "1호선", sectionTime: 59, transferTime: 0)]),
        Route(sourceStation: Station(stationName: "이수역", lineNum: "4호선"),
                  destinationStation: Station(stationName: "광화문역", lineNum: "5호선"),
                  sourceTime: Date(), destinationTime: Date(), totalTime: 50, transferCount: 1, date: "",
                  subRouteList: [SubRoute(fromStationName: "이수역", toStationName: "충무로역", lineNum: "4호선", sectionTime: 19, transferTime: 2),
                  SubRoute(fromStationName: "충무로역", toStationName: "종로3가역", lineNum: "3호선", sectionTime: 3, transferTime: 2),
                  SubRoute(fromStationName: "종로3가역", toStationName: "광화문역", lineNum: "5호선", sectionTime: 2, transferTime: 0)])
    ]
    
    static let recentRouteList : [Route] = [
        Route(sourceStation: Station(stationName: "이수역", lineNum: "4호선"),
                  destinationStation: Station(stationName: "광화문역", lineNum: "5호선"),
                  sourceTime: Date(), destinationTime: Date(), totalTime: 50, transferCount: 1, date: "12.23",
                  subRouteList: []),
        Route(sourceStation: Station(stationName: "시청역", lineNum: "1호선"),
                  destinationStation: Station(stationName: "안암역", lineNum: "6호선"),
                  sourceTime: Date(), destinationTime: Date(), totalTime: 50, transferCount: 1, date: "01.11",
                  subRouteList: [])
    ]
    
    static let searchRouteList : [Route] = [
        Route(sourceStation: Station(stationName: "숭실대입구역", lineNum: "7호선"),
                  destinationStation: Station(stationName: "이수역", lineNum: "7호선"),
                  sourceTime: Date(), destinationTime: Date(), totalTime: 4, transferCount: 0, date: "",
              subRouteList: [SubRoute(fromStationName: "숭실대입구역", toStationName: "이수역", lineNum: "7호선", sectionTime: 4, transferTime : 0)]),
        Route(sourceStation: Station(stationName: "강남역", lineNum: "2호선"),
                  destinationStation: Station(stationName: "합정역", lineNum: "2호선"),
                  sourceTime: Date(), destinationTime: Date(), totalTime: 30, transferCount: 0, date: "",
                  subRouteList: [SubRoute(fromStationName: "강남역", toStationName: "합정역", lineNum: "2호선", sectionTime: 30, transferTime: 0)]),
        Route(sourceStation: Station(stationName: "숭실대입구역", lineNum: "7호선"),
                  destinationStation: Station(stationName: "신촌역", lineNum: "2호선"),
              sourceTime: Date(), destinationTime: Date(), totalTime: 35, transferCount: 1, date: "",
                  subRouteList: [SubRoute(fromStationName: "숭실대입구역", toStationName: "대림역", lineNum: "7호선", sectionTime: 12, transferTime: 5),
                        SubRoute(fromStationName: "대림역", toStationName: "신촌역", lineNum: "2호선", sectionTime: 18, transferTime: 0)])
    ]

    static let myRoute: [Route] = [
        Route(sourceStation: Station(stationName: "숭실대입구역", lineNum: "7호선"),
                  destinationStation: Station(stationName: "신촌역", lineNum: "2호선"),
              sourceTime: Date(), destinationTime: Date(), totalTime: 35, transferCount: 1, date: "",
                  subRouteList: [SubRoute(fromStationName: "숭실대입구역", toStationName: "대림역", lineNum: "7호선", sectionTime: 12, transferTime: 5),
                        SubRoute(fromStationName: "대림역", toStationName: "신촌역", lineNum: "2호선", sectionTime: 18, transferTime: 0)])
        ]
}
