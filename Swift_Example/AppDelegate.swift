//
//  AppDelegate.swift
//  Swift_Example
//
//  Copyright (c) 2014年 FAN Communications. All rights reserved.
//

import UIKit
import NendAd

extension UINavigationController{
    open override var shouldAutorotate : Bool {
        return true
    }
    
    open override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.all
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        NADLogger.setLogLevel(.debug)
        
        NADInterstitial.sharedInstance().loadAd(withSpotID: 213208, apiKey: "308c2499c75c4a192f03c02b2fcebd16dcb45cc9")

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
        print("AppDelegate", #function)
        
        // アプリがバックグラウンドに回った場合に広告のリフレッシュを中断するには
        // AppDelegate側やそれに準じるクラスでインスタンスを保持し、このメソッドを利用してNADViewをpauseするなどしてください
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
        print("AppDelegate", #function)
        
        // アプリがバックグラウンドから復帰した場合に広告のリフレッシュを再開するには
        // AppDelegate側やそれに準じるクラスでインスタンスを保持し、このメソッドを利用してNADViewをresumeするなどしてください
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

