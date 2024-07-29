//
//  AuthAPI.swift
//  MAKAR
//
//  Created by 박지윤 on 7/29/24.
//

import Moya
import Foundation

enum AuthAPI {
    case postSignIn(id: String, password: String)
    case postSignUp(id: String, password: String, email: String, username: String)
}

extension AuthAPI: TargetType {
    var path: String {
        switch self {
        case .postSignIn:
            return URLConst.signIn
        case .postSignUp:
            return URLConst.signUp
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postSignIn, .postSignUp:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postSignIn(let id, let password):
            return .requestParameters(parameters: [
                "id": id,
                "password": password
            ], encoding: JSONEncoding.default)
        case .postSignUp(let id, let password, let email, let username):
            return .requestParameters(parameters: [
                "id": id,
                "password": password,
                "email": email,
                "username": username
            ], encoding: JSONEncoding.default)
        }
    }
}
