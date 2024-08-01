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

struct StationData: Codable {
    let stationDtoList: [StationDTO]
}

struct StationDTO: Codable {
    let stationName: String
    let lineNum: String

    init(stationName: String, lineNum: String) {
        self.stationName = stationName
        self.lineNum = lineNum
    }
}
