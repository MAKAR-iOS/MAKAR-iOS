//
//  AuthResponse.swift
//  MAKAR
//
//  Created by 김다은 on 7/27/24.
//

// MARK: - SignIn, Signup API
struct SignResponse : Codable {
    let accessToken: String
    let refreshToken: String
}
