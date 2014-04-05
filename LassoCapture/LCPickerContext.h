//
//  LCPickerContext.h
//  LassoCapture
//
//  Created by Alex Nichol on 4/4/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCToolPickerWindow.h"
#import "LCHotkey.h"
#import "LCToolList.h"

typedef enum {
  LCSaveDestinationDesktop,
  LCSaveDestinationClipboard,
  LCSaveDestination1mage
} LCSaveDestination;

@interface LCPickerContext : NSObject <LCToolDelegate> {
  NSScreen * mainScreen;
  LCToolPickerWindow * window; // current menu picker
  id<LCTool> tool;
  LCHotkey * hotKey; // tab hotkey
  LCHotkey * endHotKey; // to end the session
  NSTimer * timeout; // disable timeout
  LCSaveDestination destination;
}

- (void)startWithDestination:(LCSaveDestination)dest screen:(NSScreen *)sc;
- (void)cancel;

@end
