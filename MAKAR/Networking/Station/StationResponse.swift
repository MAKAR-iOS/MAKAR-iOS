//
//  StationResponse.swift
//  MAKAR
//
//  Created by 김다은 on 7/27/24.
//

struct StationResponse: Codable {
    let result: String
    let message: String
    let data: [StationDTOList]
    let statusCode: Int
}

struct StationDTOList: Codable {
    let stationName: String
    let lienNum: String
}
