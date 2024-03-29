//
//  AppDelegate.m
//  ObjC_Example
//
//  Copyright (c) 2015年 FAN Communications. All rights reserved.
//

#import "AppDelegate.h"

@import NendAd;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [NADLogger setLogLevel:NADLogLevelDebug];

    // インタースティシャル広告の読み込みを行います
    [[NADInterstitial sharedInstance] loadAdWithSpotID:213208 apiKey:@"308c2499c75c4a192f03c02b2fcebd16dcb45cc9"];
    
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *navBarAppearance = [[UINavigationBarAppearance alloc] init];
        [navBarAppearance configureWithOpaqueBackground];
        navBarAppearance.backgroundColor = [UIColor systemBackgroundColor];
        [UINavigationBar appearance].standardAppearance = navBarAppearance;
        [UINavigationBar appearance].compactAppearance = navBarAppearance;
        [UINavigationBar appearance].scrollEdgeAppearance = navBarAppearance;
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the
    // user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is
    // terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    NSLog(@"<<< AppDelegate applicationDidEnterBackground");

    // アプリがバックグラウンドに回った場合に広告のリフレッシュを中断するには
    // AppDelegate側やそれに準じるクラスでインスタンスを保持し、このメソッドを利用してNADViewをpauseするなどしてください
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

    NSLog(@">>> AppDelegate applicationWillEnterForeground");

    // アプリがバックグラウンドから復帰した場合に広告のリフレッシュを再開するには
    // AppDelegate側やそれに準じるクラスでインスタンスを保持し、このメソッドを利用してNADViewをresumeするなどしてください
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
