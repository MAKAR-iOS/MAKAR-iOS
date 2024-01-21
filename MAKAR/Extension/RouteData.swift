//
//  RouteData.swift
//  MAKAR
//
//  Created by 김다은 on 1/10/24.
//

import UIKit
struct RouteData {
    // TODO: 요소 수정
    let sourceStation : Station //출발역
    let destinationStation : Station //도착역
    let makarTime : Date //막차 시간
    let hakarTime : Date //하차 시간
    let totalTime : Int //탑승 시간
    let transitCount : Int
    let date : String //경로 설정한 날짜
    let subRouteItemList : [SubRouteItem]
}

extension RouteData {
    static let favoriteRouteList : [RouteData] = [
        RouteData(sourceStation: Station(stationName: "강남역", stationCode: "", lineNum: "2호선"),
                  destinationStation: Station(stationName: "숭실대입구역", stationCode: "", lineNum: "7호선"),
                  makarTime: Date(), hakarTime: Date(), totalTime: 40, transitCount: 1, date: "",
                  subRouteItemList: [
                    SubRouteItem(subRoute: SubRoute(startStationName: "강남역", endStationName: "대림역", lineNum: "2호선", sectionTime: 24),
                                 transferInfo: TransferInfo(fromLine: 2, toLine: 2, transferStation: "대림역", transferTime: 5)),
                  SubRouteItem(subRoute: SubRoute(startStationName: "대림역", endStationName: "숭실대입구역", lineNum: "7호선", sectionTime: 12),
                               transferInfo: TransferInfo(fromLine: 7, toLine: 7, transferStation: "", transferTime: 0))]),
        RouteData(sourceStation: Station(stationName: "홍대입구역", stationCode: "", lineNum: "2호선"),
                  destinationStation: Station(stationName: "신촌역", stationCode: "", lineNum: "2호선"),
                  makarTime: Date(), hakarTime: Date(), totalTime: 20, transitCount: 0, date: "",
                  subRouteItemList: [SubRouteItem(subRoute: SubRoute(startStationName: "홍대입구역", endStationName: "신촌역", lineNum: "2호선", sectionTime: 2),
                                                  transferInfo: TransferInfo(fromLine: 2, toLine: 2, transferStation: "", transferTime: 0))]),
        RouteData(sourceStation: Station(stationName: "이태원역", stationCode: "", lineNum: "6호선"),
                  destinationStation: Station(stationName: "부평역", stationCode: "", lineNum: "1호선"),
                  makarTime: Date(), hakarTime: Date(), totalTime: 73, transitCount: 1, date: "", 
                  subRouteItemList: [SubRouteItem(subRoute: SubRoute(startStationName: "이태원역", endStationName: "동묘앞역", lineNum: "6호선", sectionTime: 10),
                                                  transferInfo: TransferInfo(fromLine: 6, toLine: 6, transferStation: "동묘앞역", transferTime: 2)),
                            SubRouteItem(subRoute: SubRoute(startStationName: "동묘앞역", endStationName: "부평역", lineNum: "1호선", sectionTime: 59),
                                                 transferInfo: TransferInfo(fromLine: 1, toLine: 1, transferStation: "", transferTime: 0))]),
        RouteData(sourceStation: Station(stationName: "이수역", stationCode: "", lineNum: "4호선"),
                  destinationStation: Station(stationName: "광화문역", stationCode: "", lineNum: "5호선"),
                  makarTime: Date(), hakarTime: Date(), totalTime: 50, transitCount: 1, date: "", 
                  subRouteItemList: [SubRouteItem(subRoute: SubRoute(startStationName: "이수역", endStationName: "충무로역", lineNum: "4호선", sectionTime: 19),
                                                  transferInfo: TransferInfo(fromLine: 4, toLine: 4, transferStation: "충무로역", transferTime: 2)),
                  SubRouteItem(subRoute: SubRoute(startStationName: "충무로역", endStationName: "종로3가역", lineNum: "3호선", sectionTime: 3),
                               transferInfo: TransferInfo(fromLine: 3, toLine: 3, transferStation: "종로3가역", transferTime: 2)),
                  SubRouteItem(subRoute: SubRoute(startStationName: "종로3가역", endStationName: "광화문역", lineNum: "5호선", sectionTime: 2),
                               transferInfo: TransferInfo(fromLine: 5, toLine: 5, transferStation: "", transferTime: 0))])
    ]
    
    static let recentRouteList : [RouteData] = [
        RouteData(sourceStation: Station(stationName: "이수역", stationCode: "", lineNum: "4호선"),
                  destinationStation: Station(stationName: "광화문역", stationCode: "", lineNum: "5호선"),
                  makarTime: Date(), hakarTime: Date(), totalTime: 50, transitCount: 1, date: "12.23", 
                  subRouteItemList: []),
        RouteData(sourceStation: Station(stationName: "시청역", stationCode: "", lineNum: "1호선"),
                  destinationStation: Station(stationName: "안암역", stationCode: "", lineNum: "6호선"),
                  makarTime: Date(), hakarTime: Date(), totalTime: 50, transitCount: 1, date: "01.11", 
                  subRouteItemList: [])
    ]
    
    static let searchRouteList : [RouteData] = [
        RouteData(sourceStation: Station(stationName: "숭실대입구역", stationCode: "", lineNum: "7호선"),
                  destinationStation: Station(stationName: "이수역", stationCode: "", lineNum: "7호선"),
                  makarTime: Date(), hakarTime: Date(), totalTime: 4, transitCount: 0, date: "", 
                  subRouteItemList: [SubRouteItem(subRoute: SubRoute(startStationName: "숭실대입구역", endStationName: "이수역", lineNum: "7호선", sectionTime: 4), transferInfo: TransferInfo(fromLine: 7, toLine: 7, transferStation: "", transferTime: 0))]),
        RouteData(sourceStation: Station(stationName: "강남역", stationCode: "", lineNum: "2호선"),
                  destinationStation: Station(stationName: "합정역", stationCode: "", lineNum: "2호선"),
                  makarTime: Date(), hakarTime: Date(), totalTime: 30, transitCount: 0, date: "", 
                  subRouteItemList: [SubRouteItem(subRoute: SubRoute(startStationName: "강남역", endStationName: "합정역", lineNum: "2호선", sectionTime: 30), transferInfo: TransferInfo(fromLine: 2, toLine: 2, transferStation: "", transferTime: 0))]),
        RouteData(sourceStation: Station(stationName: "숭실대입구역", stationCode: "", lineNum: "7호선"),
                  destinationStation: Station(stationName: "신촌역", stationCode: "", lineNum: "2호선"),
                  makarTime: Date(), hakarTime: Date(), totalTime: 35, transitCount: 1, date: "", 
                  subRouteItemList: [SubRouteItem(subRoute: SubRoute(startStationName: "숭실대입구역", endStationName: "대림역", lineNum: "7호선", sectionTime: 12), transferInfo: TransferInfo(fromLine: 7, toLine: 7, transferStation: "대림", transferTime: 5)),
                                     SubRouteItem(subRoute: SubRoute(startStationName: "대림역", endStationName: "신촌역", lineNum: "2호선", sectionTime: 18), transferInfo: TransferInfo(fromLine: 2, toLine: 2, transferStation: "", transferTime: 0))
                                     ])
    ]
}
