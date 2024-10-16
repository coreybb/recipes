//
//  AppDelegate.swift
//  Recipes
//
//  Created by Corey Beebe on 10/16/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        return true
    }
    
    
    private func setupWindow() {
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = RecipesController()
    }
}

