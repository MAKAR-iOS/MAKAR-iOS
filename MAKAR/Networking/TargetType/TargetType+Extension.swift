//
//  TargetType+Extension.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/20.
//

import Foundation

import Moya

extension TargetType {
    var baseURL: URL {
        URL(string: URLConst.base)!
    }
    
    var headers: [String : String]? {
        let header = [
            "Content-Type": "application/json",
            "accessToken": UserDefaultHandler.accessToken,
            "refreshToken": UserDefaultHandler.refreshToken
        ]
        return header
    }
}
