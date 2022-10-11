//
//  AppDelegate.swift
//  JsonPlaceholder
//
//  Created by Timur on 11/10/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appSession: AppSession?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        windowSetup()
        return true
    }
    
    fileprivate func windowSetup(){
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        window.overrideUserInterfaceStyle = .light
        
        appSession = AppSession(with: window)
        appSession?.start()
    }
}

