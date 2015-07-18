//
//  AppDelegate.m
//  EnterpriseAppstore
//
//  Created by hegaokun on 15/7/7.
//  Copyright (c) 2015年 AAS. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import "LoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - Life Cycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[NSUserDefaults standardUserDefaults] objectForKey:kToken] ? [[BaseTabBarController alloc] init] : [[LoginViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Public Method
- (void)gotoHomeVC {
    UIViewController *oldVC = self.window.rootViewController;
    BaseTabBarController *newVC = [[BaseTabBarController alloc] init];
    [UIView transitionFromView:oldVC.view toView:newVC.view duration:0.6 options:UIViewAnimationOptionLayoutSubviews completion:^(BOOL finished) {
        self.window.rootViewController = newVC;
    }];
}

- (void)gotoLoginVC {
    UIViewController *oldVC = self.window.rootViewController;
    LoginViewController *newVC = [[LoginViewController alloc] init];
    [UIView transitionFromView:oldVC.view toView:newVC.view duration:0.6 options:UIViewAnimationOptionLayoutSubviews completion:^(BOOL finished) {
        self.window.rootViewController = newVC;
    }];
}

@end
