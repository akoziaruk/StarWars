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
        
        FirebaseApp.configure()

        let window = UIWindow(frame: UIScreen.main.bounds)
        self.appCoordinator = ApplicationFlowCoordinator(window: window, dependencyProvider: AppDependenciesContainer())
        self.appCoordinator.start()

        self.window = window
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

