//
//  RouteAPI.swift
//  MAKAR
//
//  Created by 김다은 on 7/29/24.
//

import Moya
import Foundation

enum RouteAPI {
    case getRouteList(
        fromStationName: String,
        fromLineNum: String,
        toStationName: String,
        toLineNum: String
    )
    case postRoute(routeId: Int)
    case deleteRoute
    case getRecentRouteList
    case getFavoriteRouteList
    case deleteRecentRoute(routeId: Int)
    case deleteAllRecentRoute
    case postFavoriteRoute(routeId: Int)
}

extension RouteAPI: TargetType {
    var path: String {
        switch self {
        case .getRouteList, .deleteRoute:
            return URLConst.route
        case .postRoute(let routeId):
            return URLConst.route + "/\(routeId)"
        case .getRecentRouteList:
            return URLConst.routeRecent
        case .getFavoriteRouteList:
            return URLConst.routeFavorite
        case .deleteRecentRoute(let routeId):
            return URLConst.routeRecent + "/\(routeId)"
        case .deleteAllRecentRoute:
            return URLConst.routeRecentAll
        case .postFavoriteRoute(let routeId):
            return URLConst.routeFavorite + "/\(routeId)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getRouteList, .getRecentRouteList, .getFavoriteRouteList:
            return .get
        case .postRoute, .postFavoriteRoute:
            return .post
        case .deleteRoute, .deleteRecentRoute, .deleteAllRecentRoute:
            return .delete
        }
    }

    var task: Moya.Task {
        switch self {
        case .getRouteList(let fromStationName,
                           let fromLineNum,
                           let toStationName,
                           let toLineNum):
            return .requestParameters(
                parameters: [
                    "fromStationName": fromStationName,
                    "fromLineNum": fromLineNum,
                    "toStationName": toStationName,
                    "toLineNum": toLineNum
                ],
                encoding: URLEncoding.queryString)
        case .postRoute,
                .deleteRoute,
                .getRecentRouteList,
                .getFavoriteRouteList,
                .deleteRecentRoute,
                .deleteAllRecentRoute,
                .postFavoriteRoute:
            return .requestPlain
        }
    }
}
