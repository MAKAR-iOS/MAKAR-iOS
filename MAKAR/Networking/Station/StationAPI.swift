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
    case getFavoriteSchool(query: String)
    case getFavoriteHome(query: String)
    case patchFavoriteSchool(stationName: String, lineNum: String)
    case patchFavoriteHome(stationName: String, lineNum: String)
}

extension StationAPI: TargetType {
    var path: String {
        switch self {
        case .getStation:
            return URLConst.getStation
        case .getFavoriteSchool, .patchFavoriteSchool:
            return URLConst.favoriteSchool
        case .getFavoriteHome, .patchFavoriteHome:
            return URLConst.favoriteHome
        }
    }

    var method: Moya.Method {
        switch self {
        case .getStation, .getFavoriteSchool, .getFavoriteHome:
            return .get
        case .patchFavoriteSchool, .patchFavoriteHome:
            return .patch
        }
    }

    var task: Moya.Task {
        switch self {
        case .getStation(let query):
            return .requestParameters(parameters: ["query": query], encoding: JSONEncoding.default)
        case .getFavoriteSchool(let query):
            return .requestParameters(parameters: ["query": query], encoding: JSONEncoding.default)
        case .getFavoriteHome(let query):
            return .requestParameters(parameters: ["query": query], encoding: JSONEncoding.default)
        case .patchFavoriteSchool(let stationName, let lineNum):
            return .requestParameters(parameters: [
                "stationName": stationName,
                "lineNum": lineNum
            ], encoding: JSONEncoding.default)
        case .patchFavoriteHome(let stationName, let lineNum):
            return .requestParameters(parameters: [
                "stationName": stationName,
                "lineNum": lineNum
            ], encoding: JSONEncoding.default)
        }
    }
}
