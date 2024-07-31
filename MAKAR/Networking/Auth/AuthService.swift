//
//  AuthService.swift
//  MAKAR
//
//  Created by 박지윤 on 7/29/24.
//

import Foundation
import Moya

final class AuthService {

    private var authProvider = MoyaProvider<AuthAPI>(plugins: [NetworkLoggerPlugin()])

    private enum ResponseData {
        case postSignIn
        case postSignUp
        case postSignOut
    }

    public func postSignIn(id: String, password: String, completion: @escaping (NetworkResult<Any>) -> Void ) {
        authProvider.request(.postSignIn(id: id, password: password)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .postSignIn)
                completion(networkResult)
            case .failure(let error):
                let networkResult = self.judgeStatus(by: error.response?.statusCode ?? 500, error.response?.data ?? Data(), responseData: .postSignIn)
                completion(networkResult)
                print(error)
            }
        }
    }

    public func postSignUp(id: String, password: String, email: String, username: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        authProvider.request(.postSignUp(id: id, password: password, email: email, username: username)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .postSignUp)
                completion(networkResult)
            case .failure(let error):
                print(error)
            }
        }
    }

    public func postSignOut(completion: @escaping (NetworkResult<Any>) -> Void) {
        authProvider.request(.postSignOut) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .postSignOut)
                completion(networkResult)
            case .failure(let error):
                print(error)
            }
        }
    }

    private func judgeStatus(by statusCode: Int, _ data: Data, responseData: ResponseData) -> NetworkResult<Any> {

        let decoder = JSONDecoder()

        switch statusCode {
        case 200..<300:
            switch responseData {
            case .postSignIn, .postSignUp, .postSignOut:
                return isValidData(data: data, responseData: responseData)
            }
        case 400..<500:
            guard let decodedData = try? decoder.decode(ErrorResponse.self, from: data) else {
                return .pathErr
            }
            return .requestErr(decodedData)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }

    private func isValidData(data: Data, responseData: ResponseData) -> NetworkResult<Any> {
        let decoder = JSONDecoder()

        switch responseData {
        case .postSignIn, .postSignUp:
            guard let decodedData = try? decoder.decode(AuthResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        case .postSignOut:
            guard let decodedData = try? decoder.decode(SignOutAuthResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        }
    }
}
