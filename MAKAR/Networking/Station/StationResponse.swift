//
//  StationResponse.swift
//  MAKAR
//
//  Created by 김다은 on 7/27/24.
//

struct StationResponse: Codable {
    let result: String
    let message: String
    let data: StationData
    let statusCode: Int
}

struct FavoriteStationResponse: Codable {
    let result: String
    let message: String
    let data: StationDTO
    let statusCode: Int
}

struct StationData: Codable {
    let stationDtoList: [StationDTO]
}

struct StationDTO: Codable {
    let stationName: String
    let lineNum: String
}
