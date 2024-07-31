//
//  StationAPI.swift
//  MAKAR
//
//  Created by 김다은 on 7/29/24.
//

import Moya
import Foundation

enum StationAPI {
    case getStation(query: String)
    case getFavoriteHome(query: String)
    case getFavoriteSchool(query: String)
    case patchFavoriteHome(stationName: String, lineNum: String)
    case patchFavoriteSchool(stationName: String, lineNum: String)
}

extension StationAPI: TargetType {
    var path: String {
        switch self {
        case .getStation:
            return URLConst.getStation
        case .getFavoriteHome, .patchFavoriteHome:
            return URLConst.favoriteHome
        case .getFavoriteSchool, .patchFavoriteSchool:
            return URLConst.favoriteSchool
        }
    }

    var method: Moya.Method {
        switch self {
        case .getStation, .getFavoriteHome, .getFavoriteSchool:
            return .get
        case .patchFavoriteHome, .patchFavoriteSchool:
            return .patch
        }
    }

    var task: Moya.Task {
        switch self {
        case .getStation(let query):
            return .requestParameters(
                parameters: [
                    "q": query
                ],
                encoding: URLEncoding.queryString)
        case .getFavoriteHome, .getFavoriteSchool:
            return .requestPlain
        case .patchFavoriteHome(let stationName, let lineNum):
            return .requestParameters(parameters: [
                "stationName": stationName,
                "lineNum": lineNum
            ], encoding: JSONEncoding.default)
        case .patchFavoriteSchool(let stationName, let lineNum):
            return .requestParameters(parameters: [
                "stationName": stationName,
                "lineNum": lineNum
            ], encoding: JSONEncoding.default)
        }
    }
}
