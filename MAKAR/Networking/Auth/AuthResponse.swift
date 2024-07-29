//
//  AuthResponse.swift
//  MAKAR
//
//  Created by 박지윤 on 7/29/24.
//

import Foundation

struct AuthResponse: Codable {
    let result: String
    let message: String
    let data: AuthData
    let statusCode: Int
}

struct AuthData: Codable {
    let accessToken: AuthToken
    let refreshToken: AuthToken
}

struct AuthToken: Codable {
    let token: String
    let expiredIn: Int
}
