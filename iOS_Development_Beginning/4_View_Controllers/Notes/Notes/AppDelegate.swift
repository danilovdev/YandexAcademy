//
//  AppDelegate.swift
//  Notes
//
//  Created by Alexey Danilov on 6/30/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import UIKit
import CocoaLumberjack

let fileNoteBook = FileNotebook()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        DDLog.add(DDOSLogger.sharedInstance)
        DDLogDebug("AppDelegate did finish launching")
        
        try? fileNoteBook.add(Note(title: "Note 1",
                              content: "Note 1 Description",
                              color: UIColor.red,
                              importance: .critical,
                              selfDestructionDate: Date()))
        
        try? fileNoteBook.add(Note(title: "Note 2 Long",
                              content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                              color: .blue,
                              importance: .usual,
                              selfDestructionDate: Date()))
        
        try? fileNoteBook.add(Note(title: "Note 3 Middle",
                              content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                              color: .green,
                              importance: .insignificant,
                              selfDestructionDate: Date()))
        
        return true
    }

}

