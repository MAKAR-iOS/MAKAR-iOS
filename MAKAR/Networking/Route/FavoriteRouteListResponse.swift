//
//  FavoriteRouteListResponse.swift
//  MAKAR
//
//  Created by 박지윤 on 8/1/24.
//

import Foundation

struct FavoriteRouteListResponse: Codable {
    let result: String
    let message: String
    let data: [BriefRouteDTO]?
    let statusCode: Int
}

struct FavoriteRoutePostListResponse: Codable {
    let result: String
    let message: String
    let data: String
    let statusCode: Int
}
