//
//  AppDelegate.swift
//  NendSDK_Swift_Sample
//
//  Created by ADN on 2014/10/03.
//  Copyright (c) 2014年 F@N Communications. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        NADInterstitial.sharedInstance().loadAdWithApiKey("308c2499c75c4a192f03c02b2fcebd16dcb45cc9", spotId: "213208")

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        
        println("AppDelegate", __FUNCTION__)
        
        // アプリがバックグラウンドに回った場合に広告のリフレッシュを中断するには
        // AppDelegate側やそれに準じるクラスでインスタンスを保持し、このメソッドを利用してNADViewをpauseするなどしてください
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        
        println("AppDelegate", __FUNCTION__)
        
        // アプリがバックグラウンドから復帰した場合に広告のリフレッシュを再開するには
        // AppDelegate側やそれに準じるクラスでインスタンスを保持し、このメソッドを利用してNADViewをresumeするなどしてください
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

