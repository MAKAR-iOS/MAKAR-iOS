//
//  NotiAPI.swift
//  MAKAR
//
//  Created by 김다은 on 7/29/24.
//

import Foundation
import Moya

enum NotiAPI {
    case postMakarNoti(routeId: Int, notiMinute: Int)
    case postGetOffNoti(routeId: Int, notiMinute: Int)
    case deleteMakarNoti(notiId: Int)
    case deleteGetOffNoti(notiId: Int)
    case getNotiList(query: String)
}

extension NotiAPI: TargetType {
    var path: String {
        switch self {
        case .postMakarNoti, .deleteMakarNoti:
            return URLConst.makar
        case .postGetOffNoti, .deleteGetOffNoti:
            return URLConst.getoff
        case .getNotiList:
            return URLConst.noti
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postMakarNoti, .postGetOffNoti:
            return .post
        case .deleteMakarNoti, .deleteGetOffNoti:
            return .delete
        case .getNotiList:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postMakarNoti(let routeId, let notiMinute), .postGetOffNoti(let routeId, let notiMinute):
            return .requestParameters(parameters: [
                "routeId": routeId,
                "notiMinute": notiMinute
            ], encoding: JSONEncoding.default)
        case .deleteMakarNoti(let notiId), .deleteGetOffNoti(let notiId):
            return .requestParameters(
                parameters: [
                    "notiId": notiId
                ], encoding: URLEncoding.default)
        case .getNotiList:
            return .requestPlain
        }
        
        
    }
}
