//
//  FavoriteStationResponse.swift
//  MAKAR
//
//  Created by 박지윤 on 8/1/24.
//

struct FavoriteStationResponse: Codable {
    let result: String
    let message: String
    let data: StationDTO
    let statusCode: Int
}

struct FavoriteStationGetResponse: Codable {
    let result: String
    let message: String
    let data: StationDTO?
    let statusCode: Int
}
