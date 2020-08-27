//
//  AppDelegate.swift
//  Spreader
//
//  Created by Anar on 23.08.2020.
//  Copyright © 2020 Commodo. All rights reserved.
//

import UIKit
import Unrealm

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    Realm.registerRealmables(SpreadsheetRow.self)
    
    self.window = UIWindow(frame: UIScreen.main.bounds)
    
    if #available(iOS 13.0, *) {
      self.window?.rootViewController = StartViewController(configurator: StartConfigurator())
    } else {
      self.window?.rootViewController = NavigationController(rootViewController: StartViewController(configurator: StartConfigurator()))
    }
    
    self.window?.makeKeyAndVisible()
    
    return true
  }
}
