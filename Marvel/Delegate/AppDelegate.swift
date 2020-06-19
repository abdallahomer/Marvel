//
//  AppDelegate.swift
//  Marvel
//
//  Created by macbook on 6/19/20.
//  Copyright © 2020 abdallahomar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setNavigationBarApperence()
        
        return true
    }
    
    private func setNavigationBarApperence() {
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = .red
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().backgroundColor = .black
        UINavigationBar.appearance().titleTextAttributes = setTitleTextAttributes(with: .white, and: 17)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10, weight: .semibold)], for: .normal)
        
        UIBarButtonItem.appearance().setTitleTextAttributes(setTitleTextAttributes(with: .white, and: 14), for: .normal)
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.red], for: .normal)

    }
    
    private func setTitleTextAttributes(with color: UIColor, and fontSize: CGFloat) -> [NSAttributedString.Key: Any]? {
        return [NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize, weight: .semibold)]
    }
}

