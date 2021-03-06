//
//  LCPickerContext.m
//  LassoCapture
//
//  Created by Alex Nichol on 4/4/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "LCPickerContext.h"
#import "LCPreferences.h"
#import "LC1mage.h"

@interface LCPickerContext (Private)

- (void)timerTick:(id)sender;
- (void)tabPressed;
- (void)endPressed;

- (void)menuChanged;

@end

@implementation LCPickerContext

- (void)startWithDestination:(LCSaveDestination)dest screen:(NSScreen *)sc {
  mainScreen = sc;
  destination = dest;
  
  tool = [LCToolList toolWithIdentifier:[LCPreferences lastToolIdentifier]];
  [tool setToolDelegate:self];
  [tool startTool];
  
  hotKey = [[LCHotkey alloc] init];
  hotKey.keyCode = [LCHotkey keyCodeForChar:@"Tab"];
  hotKey.target = self;
  hotKey.selector = @selector(tabPressed);
  [hotKey startHooking];
  
  endHotKey = [[LCHotkey alloc] init];
  endHotKey.keyCode = [LCHotkey keyCodeForChar:@"Return"];
  endHotKey.target = self;
  endHotKey.selector = @selector(endPressed);
  [endHotKey startHooking];
}

- (void)cancel {
  if (window) {
    [timeout invalidate];
    [self timerTick:nil];
  }
  [tool cancelTool];
  [hotKey stopHooking];
  [endHotKey stopHooking];
  hotKey = nil;
  endHotKey = nil;
  tool = nil;
}

#pragma mark - Tool -

- (void)lcTool:(id)sender savedImage:(NSImage *)image {
  [self cancel];
  
  if (destination == LCSaveDestinationDesktop) {
    NSString * path;
    for (int i = 0; i < 1000; i++) {
      path = [NSHomeDirectory() stringByAppendingFormat:@"/Desktop/Screenshot %d.png", i];
      if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        break;
      }
      path = nil;
    }
    
    if (!path) return;
    
    CGImageRef ref = [image CGImageForProposedRect:NULL context:nil hints:nil];
    NSBitmapImageRep * newRep = [[NSBitmapImageRep alloc] initWithCGImage:ref];
    [newRep setSize:[image size]];
    NSData * pngData = [newRep representationUsingType:NSPNGFileType properties:nil];
    [pngData writeToFile:path atomically:YES];
  } else if (destination == LCSaveDestinationClipboard) {
    NSPasteboard * pb = [NSPasteboard generalPasteboard];
    NSArray * types = [NSArray arrayWithObjects:NSTIFFPboardType, nil];
    [pb declareTypes:types owner:self];
    [pb setData:[image TIFFRepresentation] forType:NSTIFFPboardType];
  } else if (destination == LCSaveDestination1mage) {
    [LC1mage startUpload:image completed:^(NSError * err, NSURL * theURL) {
      if (err) {
        NSUserNotification * notification = [[NSUserNotification alloc] init];
        notification.title = @"Failed to upload";
        notification.informativeText = [err localizedDescription];
        notification.soundName = NSUserNotificationDefaultSoundName;
        [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
      } else {
        [[NSPasteboard generalPasteboard] declareTypes:@[NSStringPboardType] owner:nil];
        [[NSPasteboard generalPasteboard] setString:[theURL description]
                                            forType:NSStringPboardType];
        
        NSUserNotification * notification = [[NSUserNotification alloc] init];
        notification.title = @"Uploaded";
        notification.informativeText = @"Click to open in browser";
        notification.soundName = NSUserNotificationDefaultSoundName;
        notification.userInfo = @{@"url": [theURL description]};
        [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
      }
    }];
  }
}

- (void)lcToolCancelled:(id)sender {
  [self cancel];
}

#pragma mark - Private -

- (void)timerTick:(id)sender {
  timeout = nil;
  [window fadeOut];
  window = nil;
}

- (void)tabPressed {
  if (window) {
    [timeout invalidate];
    timeout = nil;
    [window.view goToNext];
    [self menuChanged];
    return;
  }
  
  window = [[LCToolPickerWindow alloc] initOnScreen:mainScreen
                                         identifier:[tool.class identifier]];
  [window.view goToNext];
  [window makeKeyAndOrderFront:nil];
  [self menuChanged];
}

- (void)endPressed {
  if (!timeout) {
    if ([tool respondsToSelector:@selector(enterPressed)]) {
      [tool enterPressed];
    }
    return;
  }
  
  [timeout invalidate];
  timeout = nil;
  [self timerTick:nil];
}

- (void)menuChanged {
  NSString * identifier = [[window.view currentCell] identifier];
  [tool cancelTool];
  tool = [LCToolList toolWithIdentifier:identifier];
  [tool setToolDelegate:self];
  [tool startTool];
  [LCPreferences setLastToolIdentifier:identifier];
  NSAssert(!timeout, @"last timeout must be gone");
  timeout = [NSTimer scheduledTimerWithTimeInterval:1 target:self
                                           selector:@selector(timerTick:)
                                           userInfo:nil repeats:NO];
}

@end
