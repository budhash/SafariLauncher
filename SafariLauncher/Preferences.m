//
//  Preferences.m
//  SafariLauncher
//
//  Created by Budhaditya Das on 6/10/13.
//  Copyright (c) 2013 Bytearc. All rights reserved.
//

#import "Preferences.h"

static NSString * const PREF_LAUNCH_URL = @"preference_launchUrl";
static NSString * const PREF_START_DELAY = @"preference_startDelay";
static NSString * const DEFAULT_URL = @"http://www.google.com";
static NSUInteger const NON_START_DELAY = 0;

@implementation Preferences

@synthesize launchUrl = launchUrl_;
@synthesize startDelay = startDelay_;
@synthesize nonStartDelay = nonStartDelay_;

static Preferences *singleton = nil;
+ (Preferences*) sharedInstance {
    if (singleton == nil) {
        singleton = [[Preferences alloc] init];
    }
    return singleton;
}

+ (void) initPreferences {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    id launchUrl = [userDefaults objectForKey:PREF_LAUNCH_URL];
    id startDelay = [userDefaults objectForKey:PREF_START_DELAY];
    
    if (launchUrl == nil || startDelay == nil) {
        NSLog(@"App setting not found. Initializing app settings to default values.");
        
        NSString* bundlePath = [[NSBundle mainBundle] bundlePath];
        NSString* settingsPath = [bundlePath stringByAppendingPathComponent:
                                  @"Settings.bundle"];
        NSString* rootPlist = [settingsPath stringByAppendingPathComponent:
                               @"Root.plist"];
        
        NSDictionary* settings = [NSDictionary dictionaryWithContentsOfFile:
                                  rootPlist];
        NSArray* preferences = [settings objectForKey:@"PreferenceSpecifiers"];
        
        NSMutableDictionary* defaultPrefs =
        [NSMutableDictionary dictionaryWithCapacity:[preferences count]];
        for (NSDictionary* item in preferences) {
            id key = [item objectForKey:@"Key"];
            if (key != nil) {
                [defaultPrefs setObject:[item objectForKey:@"DefaultValue"]
                                 forKey:key];
            }
        }
        
        [[NSUserDefaults standardUserDefaults] registerDefaults:defaultPrefs];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        NSLog(@"App settings already initialized");
    }
}


- (id)init {
    [Preferences initPreferences];
    
    // Fetching paramters from [NSUserDefaults standardUserDefaults].
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
    launchUrl_ = [defaults stringForKey:PREF_LAUNCH_URL];
    if (!launchUrl_) {
        launchUrl_ = [[Preferences getDefaultUrl] absoluteString];
        [defaults setObject:launchUrl_ forKey:PREF_LAUNCH_URL];
    }
    
    startDelay_ = [defaults integerForKey:PREF_START_DELAY];
    if (!startDelay_) {
        startDelay_ = 20;
        [defaults setObject:@"0" forKey:PREF_START_DELAY];
    }

    nonStartDelay_ = NON_START_DELAY;
    
    [defaults synchronize];
    return self;
}

+ (NSURL *) getDefaultUrl{
    return [NSURL URLWithString:DEFAULT_URL];
}
@end

