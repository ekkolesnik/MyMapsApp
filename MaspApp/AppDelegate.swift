//
//  AppDelegate.swift
//  MaspApp
//
//  Created by Evgeny Kolesnik on 31.03.2021.
//

import UIKit
import GoogleMaps
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyBOKDqm1Eru5GZ0sqX2FGky2YZkJowZvLk")
        
        let center = UNUserNotificationCenter.current()
                center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    guard granted else {
                        print("Разрешение не получено")
                        return
                    }
                    
                    self.sendNotificatioRequest(
                        content: self.makeNotificationContent(),
                        trigger: self.makeCalendarNotificatioTrigger() //self.makeIntervalNotificatioTrigger()
                    )
                }

        
        return true
    }
    
    func makeNotificationContent() -> UNNotificationContent {
            let content = UNMutableNotificationContent()
            content.title = "Пора вставать"
            content.subtitle = "7 утра"
            content.body = "Пора вершить великие дела"
            content.badge = 4
            return content
        }
        
        func makeIntervalNotificatioTrigger() -> UNNotificationTrigger {
            return UNTimeIntervalNotificationTrigger(
                timeInterval: 20,
                repeats: false
            )
        }
        
        func sendNotificatioRequest(
            content: UNNotificationContent,
            trigger: UNNotificationTrigger) {
            
            let request = UNNotificationRequest(
                identifier: "alaram",
                content: content,
                trigger: trigger
            )
            
            let center = UNUserNotificationCenter.current()
            center.add(request) { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    
    func makeCalendarNotificatioTrigger() -> UNNotificationTrigger {
            var dateInfo = DateComponents()
        
        let date = Date()
        var calendar = Calendar.current

        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        
        dateInfo.hour = hour
            dateInfo.minute = minute + 1
            return UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
        }

    


    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

