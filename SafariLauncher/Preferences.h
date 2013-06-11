//
//  Preferences.h
//  SafariLauncher
//
//  Created by Budhaditya Das on 6/10/13.
//  Copyright (c) 2013 Bytearc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Preferences: NSObject {
    
    NSString *launchUrl_;
    NSUInteger startDelay_;
    NSUInteger nonStartDelay_;
}

@property (readonly, nonatomic) NSString *launchUrl;
@property (readonly, nonatomic) NSUInteger startDelay;
@property (readonly, nonatomic) NSUInteger nonStartDelay;

// Singleton
+ (Preferences *)sharedInstance;
+ (NSURL *) getDefaultUrl;
@end
