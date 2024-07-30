//
//  AppDelegate.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     
        UNUserNotificationCenter.current().delegate = self
     
        let authorizationOptions = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
        UNUserNotificationCenter.current().requestAuthorization(options: authorizationOptions, completionHandler: { granted, error in
            if let error = error {
                print("ERROR: " + error.localizedDescription)
            }
        })

        return true
     }
 }

extension AppDelegate: UNUserNotificationCenterDelegate {
    // notification type 지정
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        completionHandler([.banner, .list, .badge, .sound])
    }
    
    // notification handler
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let targetScene = response.notification.request.content.userInfo["targetScene"]
        
        completionHandler()
    }
}


