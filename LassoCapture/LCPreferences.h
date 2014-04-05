//
//  LCPreferences.h
//  LassoCapture
//
//  Created by Alex Nichol on 4/4/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCPreferences : NSObject

+ (NSString *)lastToolIdentifier;
+ (void)setLastToolIdentifier:(NSString *)identifier;

@end
