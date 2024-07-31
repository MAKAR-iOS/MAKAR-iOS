//
//  StationService.swift
//  MAKAR
//
//  Created by 김다은 on 7/29/24.
//

import Foundation
import Moya

final class StationService {

    private var stationProvider = MoyaProvider<StationAPI>(plugins: [NetworkLoggerPlugin()])

    private enum ResponseData {
        case getStation
        case getFavoriteHome
        case getFavoriteSchool
        case patchFavoriteHome
        case patchFavoriteSchool
    }

    public func getStation(query: String, completion: @escaping (NetworkResult<Any>) -> Void ) {
        stationProvider.request(.getStation(query: query)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getStation)
                completion(networkResult)
            case .failure(let error):
                let networkResult = self.judgeStatus(by: error.response?.statusCode ?? 500, error.response?.data ?? Data(), responseData: .getStation)
                completion(networkResult)
                print(error)
            }
        }
    }

    public func getFavoriteHome(completion: @escaping (NetworkResult<Any>) -> Void ) {
        stationProvider.request(.getFavoriteHome) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getFavoriteHome)
                completion(networkResult)
            case .failure(let error):
                let networkResult = self.judgeStatus(by: error.response?.statusCode ?? 500, error.response?.data ?? Data(), responseData: .getFavoriteHome)
                completion(networkResult)
                print(error)
            }
        }
    }

    public func getFavoriteSchool(completion: @escaping (NetworkResult<Any>) -> Void ) {
        stationProvider.request(.getFavoriteSchool) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getFavoriteSchool)
                completion(networkResult)
            case .failure(let error):
                let networkResult = self.judgeStatus(by: error.response?.statusCode ?? 500, error.response?.data ?? Data(), responseData: .getFavoriteSchool)
                completion(networkResult)
                print(error)
            }
        }
    }

    public func patchFavoriteHome(stationName: String,
                                  lineNum: String,
                                  completion: @escaping (NetworkResult<Any>) -> Void ) {
        stationProvider.request(.patchFavoriteHome(
            stationName: stationName,
            lineNum: lineNum)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .patchFavoriteHome)
                completion(networkResult)
            case .failure(let error):
                let networkResult = self.judgeStatus(by: error.response?.statusCode ?? 500, error.response?.data ?? Data(), responseData: .patchFavoriteHome)
                completion(networkResult)
                print(error)
            }
        }
    }

    public func patchFavoriteSchool(stationName: String,
                                  lineNum: String,
                                  completion: @escaping (NetworkResult<Any>) -> Void ) {
        stationProvider.request(.patchFavoriteSchool(
            stationName: stationName,
            lineNum: lineNum)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data

                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .patchFavoriteSchool)
                completion(networkResult)

            case .failure(let error):
                let networkResult = self.judgeStatus(by: error.response?.statusCode ?? 500, error.response?.data ?? Data(), responseData: .patchFavoriteSchool)
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
            case .getStation, .getFavoriteSchool, .getFavoriteHome, .patchFavoriteSchool, .patchFavoriteHome:
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
        case .getStation:
            guard let decodedData = try? decoder.decode(StationResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        case .getFavoriteHome, .getFavoriteSchool:
            guard let decodedData = try? decoder.decode(FavoriteStationGetResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        case .patchFavoriteHome, .patchFavoriteSchool:
            guard let decodedData = try? decoder.decode(FavoriteStationResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        }
    }
}
