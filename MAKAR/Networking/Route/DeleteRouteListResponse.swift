//
//  DeleteRouteListResponse.swift
//  MAKAR
//
//  Created by 박지윤 on 8/1/24.
//

struct DeleteRouteListResponse: Codable {
    let result: String
    let message: String
    let data: String?
    let statusCode: Int
}
