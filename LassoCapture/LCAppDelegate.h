//
//  LCAppDelegate.h
//  LassoCapture
//
//  Created by Alex Nichol on 3/14/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LCPickerContext.h"

@interface LCAppDelegate : NSObject <NSApplicationDelegate> {
  NSArray * hotKeys;
  LCPickerContext * currentContext;
}

@property (assign) IBOutlet NSWindow * window;

- (void)handleHotkey5;
- (void)handleHotkey6;
- (void)handleHotkey7;

@end
