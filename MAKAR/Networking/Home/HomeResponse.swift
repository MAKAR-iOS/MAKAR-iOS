//
//  HomeResponse.swift
//  MAKAR
//
//  Created by 김다은 on 8/1/24.
//

struct HomeResponse: Codable {
    let result: String
    let message: String
    let data: NotiData
    let statusCode: Int
}

struct HomeData: Codable {
    let sourceStationName: String
    let destinationStationName: String
    let makarTime: String
    let getOffTime: String
    let makarNotiList: [NotiData]
    let getOffNotiList: [NotiData]
    let routeSet: Bool
}
