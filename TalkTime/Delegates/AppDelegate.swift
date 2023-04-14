//
//  AppDelegate.swift
//  TalkTime
//
//  Created by Talor Levy on 3/12/23.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import Loki
import GoogleMaps
import GooglePlaces


@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        LKManager.add(LKLanguage(name: "English", code: "en"))
        LKManager.add(LKLanguage(name: "Spanish", code: "es"))
        LKManager.add(LKLanguage(name: "German", code: "de"))
        let language = LKManager.sharedInstance()?.languages[0] as! LKLanguage
        LKManager.sharedInstance()?.currentLanguage = language
        
        GMSServices.provideAPIKey("AIzaSyBzWMCXOdQxKYgZUtaY8C3y5SVU5yVxd-s")
        GMSPlacesClient.provideAPIKey("AIzaSyBzWMCXOdQxKYgZUtaY8C3y5SVU5yVxd-s")
        
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

