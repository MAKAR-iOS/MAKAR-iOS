//
//  RouteData.swift
//  MAKAR
//
//  Created by 김다은 on 1/10/24.
//

import UIKit
struct RouteData {
    // TODO: 요소 수정
    let sourceText : String //출발역
    let sourceLine : String //출발역 호선
    let destinationText : String //도착역
    let destinationLine : String //도착역 호선
    let date : String //경로 설정한 날짜
}

extension RouteData {
    static let favoriteRouteList : [RouteData] = [
        RouteData(sourceText: "강남역", sourceLine: "2호선", destinationText: "숭실대입구역", destinationLine: "7호선", date: ""),
        RouteData(sourceText: "홍대역", sourceLine: "2호선", destinationText: "신촌역", destinationLine: "2호선", date: ""),
        RouteData(sourceText: "이태원역", sourceLine: "6호선", destinationText: "부평역", destinationLine: "1호선", date: ""),
        RouteData(sourceText: "이수역", sourceLine: "4호선", destinationText: "광화문역", destinationLine: "5호선", date: "")
    ]
    
    static let recentRouteList : [RouteData] = []
}
