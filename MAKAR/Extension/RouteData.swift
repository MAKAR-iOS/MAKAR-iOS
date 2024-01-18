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
    let totalTime : Int
    let transitCount : Int
    let date : String //경로 설정한 날짜
    let subRouteList : [SubRoute] = []
}

extension RouteData {
    static let favoriteRouteList : [RouteData] = [
        RouteData(sourceStation: Station(stationName: "강남역", stationCode: "", lineNum: "2호선"),
                  destinationStation: Station(stationName: "숭실대입구역", stationCode: "", lineNum: "7호선"),
                  makarTime: Date(), hakarTime: Date(), totalTime: 40, transitCount: 0, date: ""),
        RouteData(sourceStation: Station(stationName: "홍대역", stationCode: "", lineNum: "2호선"),
                  destinationStation: Station(stationName: "신촌역", stationCode: "", lineNum: "2호선"),
                  makarTime: Date(), hakarTime: Date(), totalTime: 20, transitCount: 0, date: ""),
        RouteData(sourceStation: Station(stationName: "이태원역", stationCode: "", lineNum: "6호선"),
                  destinationStation: Station(stationName: "부평역", stationCode: "", lineNum: "1호선"),
                  makarTime: Date(), hakarTime: Date(), totalTime: 73, transitCount: 1, date: ""),
        RouteData(sourceStation: Station(stationName: "이수역", stationCode: "", lineNum: "4호선"),
                  destinationStation: Station(stationName: "광화문역", stationCode: "", lineNum: "5호선"),
                  makarTime: Date(), hakarTime: Date(), totalTime: 50, transitCount: 1, date: "")
    ]
    
    static let recentRouteList : [RouteData] = [
        RouteData(sourceStation: Station(stationName: "이수역", stationCode: "", lineNum: "4호선"),
                  destinationStation: Station(stationName: "광화문역", stationCode: "", lineNum: "5호선"),
                  makarTime: Date(), hakarTime: Date(), totalTime: 50, transitCount: 1, date: "12.23"),
        RouteData(sourceStation: Station(stationName: "시청역", stationCode: "", lineNum: "1호선"),
                  destinationStation: Station(stationName: "안암역", stationCode: "", lineNum: "6호선"),
                  makarTime: Date(), hakarTime: Date(), totalTime: 50, transitCount: 1, date: "01.11")
    ]
    
    static let setRouteList : [RouteData] = [
        RouteData(sourceStation: Station(stationName: "숭실대입구역", stationCode: "", lineNum: "7호선"),
                  destinationStation: Station(stationName: "이수역", stationCode: "", lineNum: "7호선"),
                  makarTime: Date(), hakarTime: Date(), totalTime: 4, transitCount: 0, date: ""),
        RouteData(sourceStation: Station(stationName: "강남역", stationCode: "", lineNum: "2호선"),
                  destinationStation: Station(stationName: "합정역", stationCode: "", lineNum: "2호선"),
                  makarTime: Date(), hakarTime: Date(), totalTime: 30, transitCount: 0, date: ""),
        RouteData(sourceStation: Station(stationName: "숭실대입구역", stationCode: "", lineNum: "7호선"),
                  destinationStation: Station(stationName: "신촌역", stationCode: "", lineNum: "2호선"),
                  makarTime: Date(), hakarTime: Date(), totalTime: 35, transitCount: 1, date: "")
    ]
}