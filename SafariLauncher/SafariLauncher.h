//
//  SafariLauncher.h
//  SafariLauncher
//
//  Created by qeauto on 6/10/13.
//  Copyright (c) 2013 Bytearc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SafariLauncher : NSObject
+ (void)launch:(NSString *)url withDelay:(NSUInteger)delay;
@end
