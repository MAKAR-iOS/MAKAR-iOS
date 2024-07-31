//
//  NotiResponse.swift
//  MAKAR
//
//  Created by 김다은 on 7/27/24.
//

struct NotiResponse: Codable {
    let result: String
    let message: String
    let data: NotiData
    let statusCode: Int
}

struct NotiListResponse: Codable {
    let result: String
    let message: String
    let data: NotiListData
    let statusCode: Int
}
// MARK: -알림 추가 API
struct NotiData: Codable {
    let notiId: Int
    let notiType: String
    let notiMinute: Int
}

// MARK: -알림 삭제 API / 알림 리스트 조회 API
struct NotiListData: Codable {
    let makarNotiDtoList: [NotiData]
    let getoffNotiDtoList: [NotiData]
}
