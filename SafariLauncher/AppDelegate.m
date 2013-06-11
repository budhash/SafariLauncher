//
//  AppDelegate.m
//  SafariLauncher
//
//  Created by Budhaditya Das on 6/5/13.
//  Copyright (c) 2013 Bytearc. All rights reserved.
//

#import "AppDelegate.h"
#import "Preferences.h"
#import "SafariLauncher.h"

static BOOL foregroungCheckFlag = false;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];

    Preferences *preferences = [Preferences sharedInstance];
    NSArray * args = [[NSProcessInfo processInfo] arguments];
    if([args count] > 1) {
        NSString *urlArg = [args objectAtIndex: 1];
        [SafariLauncher launch:urlArg withDelay:preferences.startDelay];
    } else{
        [SafariLauncher launch:preferences.launchUrl withDelay:preferences.startDelay];
    }
    
	[self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    foregroungCheckFlag = true;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        if(foregroungCheckFlag){
        Preferences *preferences = [Preferences sharedInstance];
        [SafariLauncher launch:preferences.launchUrl withDelay:preferences.nonStartDelay];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    foregroungCheckFlag = false;
    Preferences *preferences = [Preferences sharedInstance];
    if (!url) {
        [SafariLauncher launch:preferences.launchUrl withDelay:preferences.nonStartDelay];
    }else{
        
        NSString *launchUrl = [[url absoluteString] substringFromIndex:5];
        if([launchUrl hasPrefix:@"http//"]){
            launchUrl = [launchUrl stringByReplacingOccurrencesOfString:@"http//"
                                                             withString:@"http://"];
        }else if([launchUrl hasPrefix:@"https//"]){
            launchUrl = [launchUrl stringByReplacingOccurrencesOfString:@"https//"
                                                             withString:@"https://"];
        }
        
        [SafariLauncher launch:launchUrl withDelay:preferences.nonStartDelay];
    }
    return YES;
}

@end
