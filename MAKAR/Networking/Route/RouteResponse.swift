//
//  RouteResponse.swift
//  MAKAR
//
//  Created by 김다은 on 7/27/24.
//

import Foundation

// MARK: -설정된 경로 조회 API
struct RouteDetailResponse : Codable {
    let routeId : Int
    let sourceStationName : String
    let sourceLineNum : String
    let destinationStationName : String
    let destinationLineNum : String
    let sourceTime : Date
    let destinationTime : Date
    let totalTime : Int
    let transferCount : Int
    let subRouteDtoList : [SubRouteDetailResponse]
}

struct SubRouteDetailResponse : Codable {
    let fromStationName : String
    let toStationName : String
    let lineNum : String
    let sectionTime : Int
    let transferTime : Int
    let path : [String]
}

// MARK: -즐겨찾는 경로 조회 API
struct FavoriteRouteResponse : Codable {
    let routeDtoList : [BriefRouteResponse]
}

struct BriefRouteResponse : Codable {
    let routeId : Int
    let sourceStationName : String
    let sourceLineNum : String
    let destinationStationName : String
    let destinationLineNum : String
}
