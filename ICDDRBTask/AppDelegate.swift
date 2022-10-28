//
//  AppDelegate.swift
//  ICDDRBTask
//
//  Created by Romana on 27/10/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
       
       func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
           let viewController = SplashController()
           viewController.modalPresentationStyle = .fullScreen
           
           window = UIWindow(frame: UIScreen.main.bounds)
           window?.rootViewController = viewController
           window?.makeKeyAndVisible()
           window?.backgroundColor = .white
           return true
       }
       
}

