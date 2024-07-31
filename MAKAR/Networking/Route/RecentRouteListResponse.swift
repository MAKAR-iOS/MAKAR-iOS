//
//  RecentRouteListResponse.swift
//  MAKAR
//
//  Created by 박지윤 on 8/1/24.
//

import Foundation

struct RecentRouteListResponse: Codable {
    let result: String
    let message: String
    let data: RecentRouteListData
    let statusCode: Int
}

struct RecentRouteListData: Codable {
    let recentRouteList: [BriefRouteDTO]?
}

struct BriefRouteDTO: Codable {
    let routeId: Int
    let sourceStationName: String
    let sourceLineNum: String
    let destinationStationName: String
    let destinationLineNum: String
}
