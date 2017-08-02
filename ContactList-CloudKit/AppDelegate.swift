//
//  AppDelegate.swift
//  ContactList-CloudKit
//
//  Created by Luis Puentes on 7/28/17.
//  Copyright © 2017 LuisPuentes. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { (didAuthorize, error) in
            if let error = error {
                print("Error authorizing user for notification: \(error)")
            }
            
            if didAuthorize { UIApplication.shared.registerForRemoteNotifications() }
        }
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        ContactsController.shared.subscribeToNewContacts()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        ContactsController.shared.fetchContacts()
    }
}

