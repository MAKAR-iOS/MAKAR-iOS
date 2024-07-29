//
//  UserDefaultHandler.swift
//  MAKAR
//
//  Created by 박지윤 on 7/29/24.
//

struct UserDefaultHandler {
    @UserDefault(key: "accessToken", defaultValue: "")
    static var accessToken: String
    
    @UserDefault(key: "refreshToken", defaultValue: "")
    static var refreshToken: String
}
