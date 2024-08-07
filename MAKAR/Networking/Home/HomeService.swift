//
//  HomeService.swift
//  MAKAR
//
//  Created by 김다은 on 8/1/24.
//

import Foundation
import Moya

final class HomeService {
    private var homeProvider = MoyaProvider<HomeAPI>(plugins: [NetworkLoggerPlugin()])
    
    private enum ResponseData {
        case getHome
    }
    
    public func getHome(completion: @escaping (NetworkResult<Any>) -> Void ) {
        homeProvider.request(.getHome)
        { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getHome)
                completion(networkResult)
                
            case .failure(let error):
                let networkResult = self.judgeStatus(by: error.response?.statusCode ?? 500, error.response?.data ?? Data(), responseData: .getHome)
                completion(networkResult)
                print(error)
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data, responseData: ResponseData) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        
        switch statusCode {
        case 200..<300:
            switch responseData {
            case .getHome:
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
        case .getHome:
            guard let decodedData = try? decoder.decode(HomeResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        }
    }
}
