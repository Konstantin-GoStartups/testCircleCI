// 
// AppDelegate.swift
//  Geocaching_pmu
//
//  Created by Konstantin Kostadinov on 5.05.20
//  Copyright (C) 2012-2020 by Activbody, Inc. All Rights Reserved.

//  Data contained herein is proprietary information of Activbody, Inc,
//  which shall be treated confidentially and shall not be used by anyone,
//  furnished to third parties or made public without prior written permission by Activbody, Inc.

//  The Activbody(TM), Activ5(TM) and TAO brands and products are fully protected
//  by international trademark, copyright and patent laws.
//  All rights reserved 2008-2020 Activbody, Inc.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var window: UIWindow? = {
        return UIApplication.shared.windows.first
    }()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
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

