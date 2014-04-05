//
//  LCCursor.m
//  LassoCapture
//
//  Created by Alex Nichol on 4/5/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "LCCursor.h"

typedef long CGSConnectionID;
extern CGSConnectionID CGSMainConnectionID(void);
extern CGError CGSSetConnectionProperty(CGSConnectionID cid,
                                        CGSConnectionID cid1,
                                        CFStringRef attr,
                                        CFBooleanRef value);

@implementation LCCursor

+ (void)gainPower {
  CGSSetConnectionProperty(CGSMainConnectionID(), CGSMainConnectionID(),
                           (__bridge_retained CFStringRef)@"SetsCursorInBackground",
                           kCFBooleanTrue);
}

@end
