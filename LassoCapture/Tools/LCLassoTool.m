//
//  LCLassoTool.m
//  LassoCapture
//
//  Created by Alex Nichol on 4/4/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "LCLassoTool.h"
#import "LCToolList.h"
#import "LCScreenshotCropper.h"
#import "LCCursor.h"

@interface LCLassoTool (Private)

- (void)cancelPressed;

@end

@implementation LCLassoTool

@synthesize toolDelegate;

+ (NSString *)identifier {
  return LCToolIdentifierLasso;
}

- (void)startTool {
  NSAssert(!path, @"cannot re-start a tool");
  path = CGPathCreateMutable();
  
  mouseTap = [[LCMouseTap alloc] init];
  eventOverlay = [[LCEventOverlay alloc] init];
  
  mouseTap.delegate = self;
  [mouseTap start];
  
  eventOverlay.color = [NSColor redColor];
  [eventOverlay begin];
  
  cancelHotkey = [[LCHotkey alloc] init];
  cancelHotkey.keyCode = [LCHotkey keyCodeForChar:@"Escape"];
  cancelHotkey.target = self;
  cancelHotkey.selector = @selector(cancelPressed);
  [cancelHotkey startHooking];
  
  [LCCursor gainPower];
  lastCursor = [NSCursor currentSystemCursor];
  NSCursor * cursor = [[NSCursor alloc] initWithImage:[NSImage imageNamed:@"lasso.png"] hotSpot:NSMakePoint(3, 21)];
	[cursor set];
}

- (void)cancelTool {
  [mouseTap cancel];
  [eventOverlay cancel];
  [cancelHotkey stopHooking];
  cancelHotkey = nil;
  mouseTap = nil;
  eventOverlay = nil;
  
  [lastCursor set];
  [LCCursor losePower];
}

- (void)dealloc {
  if (path) {
    CGPathRelease(path);
  }
}

#pragma mark - Mouse Tap -

- (void)mouseTap:(id)sender mouseDown:(NSPoint)point {
  isTapping = YES;
  CGPathMoveToPoint(path, NULL, point.x, point.y);
}

- (void)mouseTap:(id)sender mouseUp:(NSPoint)point {
  CGPathCloseSubpath(path);
  [self cancelTool];
  if (!didDrag) {
    return [self.toolDelegate lcToolCancelled:self];
  }
  
  NSImage * final = [LCScreenshotCropper cropScreenshotToPath:path];
  [self.toolDelegate lcTool:self savedImage:final];
}

- (void)mouseTap:(id)sender movedToPoint:(NSPoint)point {
  if (!isTapping) return;
  CGPathAddLineToPoint(path, NULL, point.x, point.y);
  [eventOverlay redraw:path];
  didDrag = YES;
}

#pragma mark - Private -

- (void)cancelPressed {
  [self cancelTool];
  [self.toolDelegate lcToolCancelled:self];
}

@end
