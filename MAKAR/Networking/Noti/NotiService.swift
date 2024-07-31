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
    
    
    
}
