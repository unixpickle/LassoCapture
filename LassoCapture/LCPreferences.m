//
//  LCPreferences.m
//  LassoCapture
//
//  Created by Alex Nichol on 4/4/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "LCPreferences.h"
#import "LCToolList.h"

@implementation LCPreferences

+ (NSString *)lastToolIdentifier {
  NSString * string = [[NSUserDefaults standardUserDefaults] objectForKey:@"tool"];
  NSLog(@"last tool is %@", string);
  return string ?: LCToolIdentifierNormal;
}

+ (void)setLastToolIdentifier:(NSString *)identifier {
  NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
  [defs setObject:identifier forKey:@"tool"];
  [defs synchronize];
}

@end
