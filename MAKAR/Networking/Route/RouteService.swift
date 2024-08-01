//
//  RouteService.swift
//  MAKAR
//
//  Created by 김다은 on 7/29/24.
//

import Foundation
import Moya

final class RouteService {
    
    private var routeProvider = MoyaProvider<RouteAPI>(plugins: [NetworkLoggerPlugin()])
    
    private enum ResponseData {
        case getRouteList
        case getRoute
        case postRoute
        case deleteRoute
        case getRecentRouteList
        case getFavoriteRouteList
        case deleteRecentRoute
        case deleteAllRecentRoute
        case postFavoriteRoute
        case deleteFavoriteRoute
    }
    
    public func getRouteList(
        fromStationName: String,
        fromLineNum: String,
        toStationName: String,
        toLineNum: String,
        completion: @escaping (NetworkResult<Any>) -> Void ) {
            routeProvider.request(.getRouteList(
                fromStationName: fromStationName,
                fromLineNum: fromLineNum,
                toStationName: toStationName,
                toLineNum: toLineNum)
            ) { result in
                switch result {
                case .success(let response):
                    let statusCode = response.statusCode
                    let data = response.data
                    let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getRouteList)
                    completion(networkResult)
                case .failure(let error):
                    let networkResult = self.judgeStatus(by: error.response?.statusCode ?? 500, error.response?.data ?? Data(), responseData: .getRouteList)
                    completion(networkResult)
                    print(error)
                }
            }
        }
    
    public func getRoute(completion: @escaping (NetworkResult<Any>) -> Void){
        routeProvider.request(.getRoute) {
            result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getRoute)
                completion(networkResult)
            case .failure(let error):
                let networkResult = self.judgeStatus(by: error.response?.statusCode ?? 500, error.response?.data ?? Data(), responseData: .getRoute)
                completion(networkResult)
                print(error)
            }
        }
    }

    public func postRoute(routeId: Int,
        completion: @escaping (NetworkResult<Any>) -> Void ) {
        routeProvider.request(.postRoute(routeId: routeId))
        { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .postRoute)
                completion(networkResult)
            case .failure(let error):
                let networkResult = self.judgeStatus(by: error.response?.statusCode ?? 500, error.response?.data ?? Data(), responseData: .postRoute)
                completion(networkResult)
                print(error)
            }
        }
    }

    public func deleteRoute(completion: @escaping (NetworkResult<Any>) -> Void){
        routeProvider.request(.deleteRoute) {
            result in
                switch result {
                case .success(let response):
                    let statusCode = response.statusCode
                    let data = response.data
                    let networkResult = self.judgeStatus(by: statusCode, data, responseData: .deleteRoute)
                    completion(networkResult)
                case .failure(let error):
                    let networkResult = self.judgeStatus(by: error.response?.statusCode ?? 500, error.response?.data ?? Data(), responseData: .deleteRoute)
                    completion(networkResult)
                    print(error)
                }
        }
    }

    public func getRecentRouteList(completion: @escaping (NetworkResult<Any>) -> Void ) {
        routeProvider.request(.getRecentRouteList)
        { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getRecentRouteList)
                completion(networkResult)
            case .failure(let error):
                let networkResult = self.judgeStatus(by: error.response?.statusCode ?? 500, error.response?.data ?? Data(), responseData: .getRecentRouteList)
                completion(networkResult)
                print(error)
            }
        }
    }

    public func getFavoriteRouteList(completion: @escaping (NetworkResult<Any>) -> Void ) {
        routeProvider.request(.getFavoriteRouteList)
        { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .getFavoriteRouteList)
                completion(networkResult)
            case .failure(let error):
                let networkResult = self.judgeStatus(by: error.response?.statusCode ?? 500, error.response?.data ?? Data(), responseData: .getFavoriteRouteList)
                completion(networkResult)
                print(error)
            }
        }
    }

    public func deleteRecentRoute(routeId: Int,
        completion: @escaping (NetworkResult<Any>) -> Void ) {
        routeProvider.request(.deleteRecentRoute(routeId: routeId))
        { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .deleteRecentRoute)
                completion(networkResult)

            case .failure(let error):
                let networkResult = self.judgeStatus(by: error.response?.statusCode ?? 500, error.response?.data ?? Data(), responseData: .deleteRecentRoute)
                completion(networkResult)
                print(error)
            }
        }
    }

    public func deleteAllRecentRoute(completion: @escaping (NetworkResult<Any>) -> Void ) {
        routeProvider.request(.deleteAllRecentRoute)
        { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .deleteAllRecentRoute)
                completion(networkResult)

            case .failure(let error):
                let networkResult = self.judgeStatus(by: error.response?.statusCode ?? 500, error.response?.data ?? Data(), responseData: .deleteAllRecentRoute)
                completion(networkResult)
                print(error)
            }
        }
    }

    public func postFavoriteRoute(routeId: Int,
                                      completion: @escaping (NetworkResult<Any>) -> Void ) {
        routeProvider.request(.postFavoriteRoute(routeId: routeId))
        { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .postFavoriteRoute)
                completion(networkResult)
            case .failure(let error):
                let networkResult = self.judgeStatus(by: error.response?.statusCode ?? 500, error.response?.data ?? Data(), responseData: .postFavoriteRoute)
                completion(networkResult)
                print(error)
            }
        }
    }

    public func deleteFavoriteRoute(routeId: Int,
                                      completion: @escaping (NetworkResult<Any>) -> Void ) {
        routeProvider.request(.deleteFavoriteRoute(routeId: routeId))
        { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, responseData: .deleteFavoriteRoute)
                completion(networkResult)
            case .failure(let error):
                let networkResult = self.judgeStatus(by: error.response?.statusCode ?? 500, error.response?.data ?? Data(), responseData: .deleteFavoriteRoute)
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
            case .getRouteList, .getRoute, .postRoute, .deleteRoute, .getFavoriteRouteList, .getRecentRouteList, .deleteRecentRoute, .deleteAllRecentRoute, .postFavoriteRoute, .deleteFavoriteRoute:
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
        case .getRouteList:
            guard let decodedData = try? decoder.decode(RouteListResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        case .postRoute:
            guard let decodedData = try? decoder.decode(RouteSetResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        case .getRoute:
            guard let decodedData = try? decoder.decode(RouteGetResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData) 
        case .deleteRoute:
            guard let decodedData = try? decoder.decode(RouteDeleteResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        case .getFavoriteRouteList, .deleteFavoriteRoute:
            guard let decodedData = try? decoder.decode(FavoriteRouteListResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        case .postFavoriteRoute:
            guard let decodedData = try? decoder.decode(FavoriteRoutePostListResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        case .getRecentRouteList:
            guard let decodedData = try? decoder.decode(RecentRouteListResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        case .deleteRoute, .deleteRecentRoute, .deleteAllRecentRoute:
            guard let decodedData = try? decoder.decode(DeleteRouteListResponse.self, from: data) else {
                return .pathErr
            }
            return .success(decodedData)
        }
    }
}
