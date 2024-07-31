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
    static let signIn = "/api/v1/auth/sign-in"
    static let signUp = "/api/v1/auth/sign-up"
    static let signOut = "/api/v1/auth/sign-out"

    // MARK: - Route
    static let route = "/api/v1/route"
    static let routeSet = "/api/v1/route/set"
    static let routeRecent = "/api/v1/route/recent"
    static let routeFavorite = "/api/v1/route/favorite"
    static let routeRecentAll = "/api/v1/route/recent/all"

    // MARK: - Noti
    static let makar = "/api/v1/noti/makar"
    static let getoff = "/api/v1/noti/getoff"
    static let noti = "/api/v1/noti"

    // MARK: - Station
    static let favoriteSchool = "/api/v1/station/favorite/school"
    static let favoriteHome = "/api/v1/station/favorite/home"
    static let stationDetail = "/api/v1/station/detail"
    static let getStation = "/api/v1/station"
    
    // MARK: - Home
    static let home = "/api/v1/home"
}
