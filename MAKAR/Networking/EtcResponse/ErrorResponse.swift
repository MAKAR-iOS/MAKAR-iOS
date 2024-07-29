//
//  ErrorResponse.swift
//  MAKAR
//
//  Created by 박지윤 on 7/29/24.
//

struct ErrorResponse: Codable {
    let timeStamp: String?
    let status: Int?
    let error: String?
    let message: String?
}
