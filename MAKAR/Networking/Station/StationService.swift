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
        case getFavoriteSchool
        case getFavoriteHome
        case patchFavoriteSchool
        case patchFavoriteHome
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
        case .getStation, .getFavoriteSchool, .getFavoriteHome, .patchFavoriteSchool, .patchFavoriteHome:
            guard let decodedData = try? decoder.decode(StationResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        }
    }
}
