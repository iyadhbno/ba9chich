//
//  AppDelegate.swift
//  ba9chich
//
//  Created by User on 23.06.2022.
//

import UIKit
import CometChatPro
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

let appId = "213092b32d994fa0"
let region = "us"
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let mySettings = AppSettings.AppSettingsBuilder(
        ).subscribePresenceForAllUsers().setRegion(region: region).build()
        CometChat(appId: appId, appSettings: mySettings) { (isSuccess) in
         print("CometChat PRO SDK succefly")
        } onError: { (error) in
            print("CometChat PRO SDK error")
        }

        // Override point for customization after application launch.
        return true
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

