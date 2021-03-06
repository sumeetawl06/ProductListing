//
//  AppDelegate.swift
//  foodpanda-product-listing
//
//  Created by Shahin Gharebaghi on 27/10/20.
//  Copyright © 2020 foodpanda. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
        window = UIWindow(frame: UIScreen.main.bounds)
        let productList = ProductListRouter.createModule()
        window?.rootViewController = productList
        window?.makeKeyAndVisible()
        
        // Override point for customization after application launch.
        return true
    }
}

