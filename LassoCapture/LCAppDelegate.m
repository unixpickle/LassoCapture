//
//  LCAppDelegate.m
//  LassoCapture
//
//  Created by Alex Nichol on 3/14/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "LCAppDelegate.h"

@implementation LCAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
  
  hotKeys = @[[[LCHotkey alloc] init], [[LCHotkey alloc] init], [[LCHotkey alloc] init]];
  for (int i = 0; i < 3; i++) {
    LCHotkey * hk = hotKeys[i];
    hk.modifiers = LCHotkeyModifierShift | LCHotkeyModifierCommand;
    hk.keyCode = [LCHotkey keyCodeForChar:[NSString stringWithFormat:@"%c", '5' + i]];
    hk.target = self;
    hk.selector = NSSelectorFromString([NSString stringWithFormat:@"handleHotkey%d", i + 5]);
    [hk startHooking];
  }
}

- (void)handleHotkey5 {
  [currentContext cancel];
  currentContext = [[LCPickerContext alloc] init];
  [currentContext startWithDestination:LCSaveDestinationClipboard screen:[NSScreen mainScreen]];
}

- (void)handleHotkey6 {
  [currentContext cancel];
  currentContext = [[LCPickerContext alloc] init];
  [currentContext startWithDestination:LCSaveDestination1mage screen:[NSScreen mainScreen]];
}

- (void)handleHotkey7 {
  [currentContext cancel];
  currentContext = [[LCPickerContext alloc] init];
  [currentContext startWithDestination:LCSaveDestinationDesktop screen:[NSScreen mainScreen]];
}

- (void)userNotificationCenter:(NSUserNotificationCenter *)center didActivateNotification:(NSUserNotification *)notification {
  NSString * url = notification.userInfo[@"url"];
  if (url) {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:url]];
  }
}

- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center shouldPresentNotification:(NSUserNotification *)notification {
  return YES;
}

@end
