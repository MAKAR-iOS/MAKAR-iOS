//
//  Noti.swift
//  MAKAR
//
//  Created by 김다은 on 7/30/24.
//

struct Noti {
    let notiId : Int
    let notiType : NotiType
    let notiMinute: Int
}

enum NotiType {
    case MAKAR
    case GETOFF
}


extension Noti {
    static let makarNotiList : [Noti] = [
        Noti(notiId: 1, notiType: NotiType.MAKAR, notiMinute: 1),
        Noti(notiId: 2, notiType: NotiType.MAKAR, notiMinute: 2)
//        Noti(notiId: 3, notiType: NotiType.MAKAR, notiMinute: 3)
    ]
    
    static let getOffNotiList : [Noti] = [
        Noti(notiId: 4, notiType: NotiType.GETOFF, notiMinute: 1),
        Noti(notiId: 5, notiType: NotiType.GETOFF, notiMinute: 2)
    ]
}

