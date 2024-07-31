//
//  HomeAPI.swift
//  MAKAR
//
//  Created by 김다은 on 8/1/24.
//


import Foundation
import Moya

enum HomeAPI {
    case getHome
}

extension HomeAPI: TargetType {
    var path: String {
        switch self {
        case .getHome:
            return URLConst.home
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getHome:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getHome:
            return .requestPlain
        }
    }
    
}
