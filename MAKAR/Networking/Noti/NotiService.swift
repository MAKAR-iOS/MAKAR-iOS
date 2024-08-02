//
//  NotiService.swift
//  MAKAR
//
//  Created by 김다은 on 7/29/24.
//

import Foundation
import Moya

final class NotiService {
    
    private var notiProvider = MoyaProvider<NotiAPI>(plugins: [NetworkLoggerPlugin()])
    
    private enum ResponseData {
        case postMakarNoti
        case postGetOffNoti
        case deleteMakarNoti
        case deleteGetOffNoti
        case getNotiList
    }
    
    public func postMakarNoti(routeId: Int, notiMinute: Int, completion: @escaping (NetworkResult<Any>) -> Void ) {
        notiProvider.request(.postMakarNoti(routeId: routeId, notiMinute: notiMinute))
        { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .postMakarNoti)
                completion(networkResult)
                
            case .failure(let error):
                let networkResult = self.judgeStatus(by: error.response?.statusCode ?? 500, error.response?.data ?? Data(), responseData: .postMakarNoti)
                completion(networkResult)
                print(error)
            }
        }
    }
    
    public func postGetOffNoti(routeId: Int, notiMinute: Int, completion: @escaping (NetworkResult<Any>) -> Void ) {
        notiProvider.request(.postGetOffNoti(routeId: routeId, notiMinute: notiMinute))
        { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .postGetOffNoti)
                completion(networkResult)
                
            case .failure(let error):
                let networkResult = self.judgeStatus(by: error.response?.statusCode ?? 500, error.response?.data ?? Data(), responseData: .postGetOffNoti)
                completion(networkResult)
                print(error)
            }
        }
    }
    
    public func deleteMakarNoti(notiId: Int, completion: @escaping (NetworkResult<Any>) -> Void ) {
        notiProvider.request(.deleteMakarNoti(notiId: notiId))
        { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .deleteMakarNoti)
                completion(networkResult)
                
            case .failure(let error):
                let networkResult = self.judgeStatus(by: error.response?.statusCode ?? 500, error.response?.data ?? Data(), responseData: .deleteMakarNoti)
                completion(networkResult)
                print(error)
            }
        }
    }
    
    public func deleteGetOffNoti(notiId: Int, completion: @escaping (NetworkResult<Any>) -> Void ) {
        notiProvider.request(.deleteGetOffNoti(notiId: notiId))
        { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .deleteGetOffNoti)
                completion(networkResult)
                
            case .failure(let error):
                let networkResult = self.judgeStatus(by: error.response?.statusCode ?? 500, error.response?.data ?? Data(), responseData: .deleteGetOffNoti)
                completion(networkResult)
                print(error)
            }
        }
    }
    
    public func getNotiList(completion: @escaping (NetworkResult<Any>) -> Void ) {
        notiProvider.request(.getNotiList)
        { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getNotiList)
                completion(networkResult)
                
            case .failure(let error):
                let networkResult = self.judgeStatus(by: error.response?.statusCode ?? 500, error.response?.data ?? Data(), responseData: .getNotiList)
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
            case .postMakarNoti,
                    .postGetOffNoti,
                    .deleteMakarNoti,
                    .deleteGetOffNoti,
                    .getNotiList:
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
        case .postMakarNoti,
                .postGetOffNoti:
            guard let decodedData = try? decoder.decode(NotiResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        case .deleteMakarNoti,
                .deleteGetOffNoti,
                .getNotiList:
            guard let decodedData = try? decoder.decode(NotiListResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        }
    }
}
    
    

