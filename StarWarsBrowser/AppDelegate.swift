//
//  AppDelegate.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 25.05.2021.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: ApplicationFlowCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        self.appCoordinator = ApplicationFlowCoordinator(window: window, dependencyProvider: ApplicationComponentsFactory())
        self.appCoordinator.start()

        self.window = window
        self.window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        
        return true
    }
}

