//
//  AppDelegate.swift
//  CovidiOS
//
//  Created by Nguyen Duc Manh on 6/21/20.
//  Copyright © 2020 Nguyen Duc Manh. All rights reserved.
//

import UIKit
import Flutter

@UIApplicationMain
class AppDelegate: FlutterAppDelegate {
    lazy var flutterEngineHalfScreen = FlutterEngine(name: "FLUTTER_ENGINE_HALF_ID")
    lazy var flutterEngineFullScreen = FlutterEngine(name: "FLUTTER_ENGINE_ID")


//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//        return true
//    }
//
//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }

    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Pre-warm flutter
        flutterEngineHalfScreen.run();
        flutterEngineFullScreen.run();
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions);
    }
}

