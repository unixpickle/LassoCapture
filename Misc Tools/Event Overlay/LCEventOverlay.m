//
//  LCEventOverlay.m
//  LassoCapture
//
//  Created by Alex Nichol on 4/4/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "LCEventOverlay.h"
#import "LCEventOverlayView.h"

@implementation LCEventOverlay

- (id)init {
  if ((self = [super init])) {
    NSMutableArray * mWindows = [NSMutableArray array];
    for (NSScreen * s in [NSScreen screens]) {
      NSWindow * window = [[NSWindow alloc] initWithContentRect:NSMakeRect(0, 0, s.frame.size.width, s.frame.size.height)
                                                      styleMask:NSBorderlessWindowMask
                                                        backing:NSBackingStoreBuffered
                                                          defer:NO
                                                         screen:s];
      LCEventOverlayView * view = [[LCEventOverlayView alloc] init];
      view.generalOffset = s.frame.origin;
      window.contentView = view;
      [window setLevel:CGShieldingWindowLevel()];
      [window setOpaque:NO];
      [window setBackgroundColor:[NSColor clearColor]];
      [window setIgnoresMouseEvents:NO];
      [mWindows addObject:window];
    }
    windows = [mWindows copy];
  }
  return self;
}

- (void)begin {
  for (NSWindow * window in windows) {
    [window makeKeyAndOrderFront:nil];
  }
}

- (void)cancel {
  for (NSWindow * window in windows) {
    [window orderOut:nil];
  }
}

- (void)redraw:(CGPathRef)path {
  for (NSWindow * window in windows) {
    LCEventOverlayView * view = window.contentView;
    [view setPath:path];
    [view setStrokeColor:self.color];
    [view setNeedsDisplay:YES];
    [view setHasCurrentPoint:NO];
  }
}

- (void)redraw:(CGPathRef)path currentPoint:(CGPoint)p {
  for (NSWindow * window in windows) {
    LCEventOverlayView * view = window.contentView;
    [view setPath:path];
    [view setStrokeColor:self.color];
    [view setNeedsDisplay:YES];
    [view setCurrentPoint:p];
    [view setHasCurrentPoint:YES];
  }
}

@end
