//
//  AppDelegate.swift
//  CSGOHackGUI
//
//  Created by Kaan Uyumaz on 15.08.2019.
//  Copyright © 2019 Kaan Uyumaz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let connectionNav = MainNavigationController()
        let connectionVC = ConnectionViewController()
        
        let wallNav = MainNavigationController()
        let wallVC = WallHackViewController()
        
        let aimNav = MainNavigationController()
        let aimVC = AimHackViewController()
        
        let miscNav = MainNavigationController()
        let miscVC = MiscViewController()
        
        let tabBarCont = UITabBarController()
        
        connectionNav.title = "Connection"
        connectionVC.title = "Connection"
        
        wallNav.title = "Visuals"
        wallVC.title = "Visuals"
        
        aimNav.title = "Aim"
        aimVC.title = "Aim"
        
        miscNav.title = "Miscs"
        miscVC.title = "Miscs"
        
        connectionNav.viewControllers = [connectionVC]
        wallNav.viewControllers = [wallVC]
        aimNav.viewControllers = [aimVC]
        miscNav.viewControllers = [miscVC]
        
        tabBarCont.viewControllers = [connectionNav, wallNav, aimNav, miscNav]
        tabBarCont.tabBar.items![1].isEnabled = false
        tabBarCont.tabBar.items![2].isEnabled = false
        tabBarCont.tabBar.items![3].isEnabled = false
        
        let gl = CAGradientLayer()
        gl.colors = [UIColor.white.cgColor, UIColor(red: 66/255, green: 87/255, blue: 87/255, alpha: 1).cgColor]
        gl.frame = CGRect(x: tabBarCont.tabBar.bounds.minX, y: tabBarCont.tabBar.bounds.minY, width: tabBarCont.tabBar.bounds.width, height: tabBarCont.tabBar.bounds.height * 15)
        gl.locations = [0.0, 0.13]
        tabBarCont.tabBar.barTintColor = UIColor(patternImage: MainNavigationController().getImageFrom(gradientLayer: gl))
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.makeKeyAndVisible()
        window?.rootViewController = tabBarCont
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

