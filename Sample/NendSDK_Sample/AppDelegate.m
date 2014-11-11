//
//  AppDelegate.m
//  NendSDK_Sample
//
//  Created by ADN on 2013/07/19.
//  Copyright (c) 2013年 F@N Communications. All rights reserved.
//

#import "AppDelegate.h"

#import "SelectTableViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    SelectTableViewController* selectTableViewController = [[SelectTableViewController alloc] init];
    UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:selectTableViewController];
    
    self.window.rootViewController = navigationController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

#pragma mark - Did Enter Background.
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"<<< AppDelegate applicationDidEnterBackground");
    
    // アプリがバックグラウンドに回った場合に広告のリフレッシュを中断するには
    // AppDelegate側やそれに準じるクラスでインスタンスを保持し、このメソッドを利用してNADViewをpauseするなどしてください
}

#pragma mark - Will Enter Foreground.
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@">>> AppDelegate applicationWillEnterForeground");
    
    // アプリがバックグラウンドから復帰した場合に広告のリフレッシュを再開するには
    // AppDelegate側やそれに準じるクラスでインスタンスを保持し、このメソッドを利用してNADViewをresumeするなどしてください
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
