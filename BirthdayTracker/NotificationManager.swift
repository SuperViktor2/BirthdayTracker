//
//  NotificationManager.swift
//  BirthdayTracker
//
//  Created by Viktor Goleš on 26.11.2022..
//

import Foundation
import UserNotifications


class NotificationManager {
    
    static let instance = NotificationManager()
    
    
    
    func requestAuthorizaiton() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (succsess, error) in
            if let error = error {
                print("error \(error)")
            } else {
                print("Authorization succsessfull")
            }
        }
    }
    
    func scheduleNotificatoin () {
        
        let content = UNMutableNotificationContent()
        content.title = "Your friend has a birthday today!"
        content.subtitle = "Go tell them happy birthday!"
        content.sound = .default
        content.badge = 1
        
        var dateComponents = DateComponents()
        dateComponents.hour = 18
        dateComponents.minute = 42
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString, content: content, trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
    }
    
    
}
