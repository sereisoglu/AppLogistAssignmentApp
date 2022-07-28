//
//  AppDelegate.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/28/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        window?.rootViewController = HomeController()
        
        return true
    }
}
