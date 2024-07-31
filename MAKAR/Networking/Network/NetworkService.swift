//
//  NetworkService.swift
//  MAKAR
//
//  Created by 박지윤 on 7/29/24.
//

final class NetworkService {
    static let shared = NetworkService()

    private init() { }

    let auth = AuthService()
    let station = StationService()
    let route = RouteService()
    let noti = NotiService()
    let home = HomeService()
}
