//
//  URLConst.swift
//  MAKAR
//
//  Created by 박지윤 on 7/29/24.
//

enum URLConst {
    // MARK: - baseURL
    static let base = "http://43.203.204.238:8080"
    
    // MARK: - AppInfoURL
    
    // MARK: - Auth
    static let signIn = "/auth/sign-in"
    static let signUp = "/auth/sign-up"

    // MARK: - Route
    static let route = "/api/v1/route"
    static let routeSet = "/api/v1/route/set"

    // MARK: - Noti
    static let makar = "/noti/makar"
    static let getoff = "/noti/getoff"
    static let noti = "/noti"

    // MARK: - Station
    static let favoriteSchool = "/api/v1/station/favorite/school"
    static let favoriteHome = "/api/v1/station/favorite/home"
    static let stationDetail = "/api/v1/station/detail"
    static let getStation = "/api/v1/station"
}
