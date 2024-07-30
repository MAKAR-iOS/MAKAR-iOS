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
}

extension RouteAPI: TargetType {
    var path: String {
        switch self {
        case .getRouteList, .deleteRoute:
            return URLConst.route
        case .postRoute(let routeId):
            return URLConst.route + "/\(routeId)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getRouteList:
            return .get
        case .postRoute:
            return .post
        case .deleteRoute:
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
        case .postRoute, .deleteRoute:
            return .requestPlain
        }
    }
}
