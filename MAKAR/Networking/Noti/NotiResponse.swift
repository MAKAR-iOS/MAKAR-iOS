//
//  NotiResponse.swift
//  MAKAR
//
//  Created by 김다은 on 7/27/24.
//

// MARK: -알림 추가 API
struct NotiResponse : Codable {
    let notiId : Int
    let notiType : String
    let notiMinute : Int
}

// MARK: -알림 삭제 API / 알림 리스트 조회 API
struct NotiListResponse : Codable {
    let makarNotiDtoList : [NotiResponse]
    let getoffNotiDtoList : [NotiResponse]
}
