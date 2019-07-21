//
//  AppDelegate.swift
//  Notes
//
//  Created by Alexey Danilov on 6/30/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import UIKit
import CocoaLumberjack

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        DDLog.add(DDOSLogger.sharedInstance)
        DDLogDebug("AppDelegate did finish launching")
        
        return true
    }

}

