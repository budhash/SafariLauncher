//
//  SafariLauncher.m
//  SafariLauncher
//
//  Created by qeauto on 6/10/13.
//  Copyright (c) 2013 Bytearc. All rights reserved.
//

#import "SafariLauncher.h"
#import "Preferences.h"

@implementation SafariLauncher

+ (void)launch:(NSString *)url withDelay:(NSUInteger)delay{
    Preferences *preferences = [Preferences sharedInstance];

    NSLog(@"Waiting for %lu seconds", (unsigned long)delay);
    [NSThread sleepForTimeInterval:delay];
    
    NSURL *launchUrl = [NSURL URLWithString: url];
    
    if(launchUrl == nil || (![[launchUrl scheme] isEqualToString:@"http"] && ![[launchUrl scheme] isEqualToString:@"https"])) {
        NSLog(@"Invalid URL [%@] specified. Trying settings URL", url);

        launchUrl = [NSURL URLWithString: preferences.launchUrl];
        
        if(launchUrl == nil || (![[launchUrl scheme] isEqualToString:@"http"] && ![[launchUrl scheme] isEqualToString:@"https"])) {
            NSLog(@"Invalid settings URL [%@]. Launching default URL", preferences.launchUrl);
            launchUrl = [Preferences getDefaultUrl]; 
        }
    }
    NSLog(@"Launching URL - %@", launchUrl);
    [[UIApplication sharedApplication] openURL:launchUrl];
    
}

@end
