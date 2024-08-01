//
//  RouteListResponse.swift
//  MAKAR
//
//  Created by 박지윤 on 7/30/24.
//

import Foundation

struct RouteListResponse: Codable {
    let result: String
    let message: String
    let data: RouteListData
    let statusCode: Int
}

struct RouteGetResponse: Codable {
    let result: String
    let message: String
    let data: RouteDTO
    let statusCode: Int
}

struct RouteSetResponse: Codable {
    let result: String
    let message: String
    let data: RouteDTO?
    let statusCode: Int
}

struct RouteListData: Codable {
    let routeDtoList: [RouteDTO]
}

struct RouteDTO: Codable {
    let routeId: Int
    let sourceStationName: String
    let sourceLineNum: String
    let destinationStationName: String
    let destinationLineNum: String
    let sourceTime: String
    let destinationTime: String
    let totalTime: Int
    let transferCount: Int
    let subRouteDtoList: [SubRouteDTO]
}

struct SubRouteDTO: Codable {
    let fromStationName: String
    let toStationName: String
    let lineNum: String
    let sectionTime: Int
    let transferTime: Int
    let path: [String]
}
