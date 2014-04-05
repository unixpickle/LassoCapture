//
//  LCPickerContext.m
//  LassoCapture
//
//  Created by Alex Nichol on 4/4/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "LCPickerContext.h"

@interface LCPickerContext (Private)

- (void)timerTick:(id)sender;
- (void)tabPressed;

@end

@implementation LCPickerContext

- (void)startWithDestination:(LCSaveDestination)dest screen:(NSScreen *)sc {
  mainScreen = sc;
  destination = dest;
  
  tool = [LCToolList toolWithIdentifier:LCToolIdentifierNormal];
  [tool setToolDelegate:self];
  [tool startTool];
  
  hotKey = [[LCHotkey alloc] init];
  hotKey.keyCode = [LCHotkey keyCodeForChar:@"Tab"];
  hotKey.target = self;
  hotKey.selector = @selector(tabPressed);
  [hotKey startHooking];
}

- (void)cancel {
  if (window) {
    [timeout invalidate];
    [self timerTick:nil];
  }
  [tool cancelTool];
  [hotKey stopHooking];
  hotKey = nil;
  tool = nil;
}

#pragma mark - Tool -

- (void)lcTool:(id)sender savedImage:(NSImage *)image {
  [self cancel];
}

- (void)lcToolCancelled:(id)sender {
  [self cancel];
}

#pragma mark - Private -

- (void)timerTick:(id)sender {
  timeout = nil;
  [window orderOut:nil];
  window = nil;
}

- (void)tabPressed {
  if (window) {
    [timeout invalidate];
    timeout = [NSTimer timerWithTimeInterval:1 target:self
                                    selector:@selector(timerTick:)
                                    userInfo:nil repeats:NO];
    [window.view goToNext];
    return;
  }
  window = [[LCToolPickerWindow alloc] initOnScreen:mainScreen
                                         identifier:[tool.class identifier]];
  [window.view goToNext];
  [window makeKeyAndOrderFront:nil];
  timeout = [NSTimer timerWithTimeInterval:1 target:self
                                  selector:@selector(timerTick:)
                                  userInfo:nil repeats:NO];
}

@end
