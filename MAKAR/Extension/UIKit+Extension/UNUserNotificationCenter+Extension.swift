//
//  UNUserNotificationCenter+Extension.swift
//  MAKAR
//
//  Created by 김다은 on 7/30/24.
//

import UserNotifications

extension UNUserNotificationCenter {
    
    func addNotificationRequest(notiType: String, minute: Int) {
        
        let content = UNMutableNotificationContent()
        content.title = "MAKAR"
        content.body = "\(notiType)까지 \(minute)분 남았습니다"
        content.sound = .default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        self.add(request, withCompletionHandler: nil)
    }
}
