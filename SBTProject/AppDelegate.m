//
//  AppDelegate.m
//  SBTProject
//
//  Created by Константин Богданов on 11.12.17.
//  Copyright © 2017 Константин Богданов. All rights reserved.
//

#import "AppDelegate.h"
#import "KVBLocationViewController.h"
#import "KVBPersistentContainer.h"


@interface AppDelegate ()


@property(nonatomic, strong) KVBPersistentContainer *persistentContainer;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [UIWindow new];
    self.window.frame = UIScreen.mainScreen.bounds;
    
    self.persistentContainer = [KVBPersistentContainer new];
    
    KVBLocationViewController *welcomeVC = [[KVBLocationViewController alloc] initWithContext:self.persistentContainer.persistentContainer.viewContext];
    
    self.window.rootViewController = welcomeVC;

    [self.window makeKeyAndVisible];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [self.persistentContainer.persistentContainer.viewContext save:nil];
}

@end
