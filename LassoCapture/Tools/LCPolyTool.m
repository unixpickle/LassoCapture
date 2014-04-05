//
//  LCPolyTool.m
//  LassoCapture
//
//  Created by Alex Nichol on 4/5/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "LCPolyTool.h"
#import "LCToolList.h"
#import "LCScreenshotCropper.h"
#import "LCCursor.h"

@interface LCPolyTool (Private)

- (void)cancelPressed;

@end

@implementation LCPolyTool

@synthesize toolDelegate;

+ (NSString *)identifier {
  return LCToolIdentifierPoly;
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
  lastCursor = [NSCursor currentCursor];
  [[NSCursor crosshairCursor] set];
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

- (void)enterPressed {
  if (!hasStarted) {
    [self cancelTool];
    return [self.toolDelegate lcToolCancelled:self];
  }
  
  CGPathCloseSubpath(path);
  [self cancelTool];
  
  NSImage * final = [LCScreenshotCropper cropScreenshotToPath:path];
  [self.toolDelegate lcTool:self savedImage:final];
}

- (void)dealloc {
  if (path) {
    CGPathRelease(path);
  }
}

#pragma mark - Mouse Tap -

- (void)mouseTap:(id)sender mouseDown:(NSPoint)point {
  if (!hasStarted) {
    hasStarted = YES;
    initialPoint = point;
    CGPathMoveToPoint(path, NULL, point.x, point.y);
  } else {
    if (sqrt(pow(point.x - initialPoint.x, 2) + pow(point.y - initialPoint.y, 2)) < 7) {
      return [self enterPressed];
    }
    CGPathAddLineToPoint(path, NULL, point.x, point.y);
  }
  [eventOverlay redraw:path];
}

- (void)mouseTap:(id)sender mouseUp:(NSPoint)point {
}

- (void)mouseTap:(id)sender movedToPoint:(NSPoint)point {
  if (!hasStarted) return;
  [eventOverlay redraw:path currentPoint:NSPointToCGPoint(point)];
}

#pragma mark - Private -

- (void)cancelPressed {
  [self cancelTool];
  [self.toolDelegate lcToolCancelled:self];
}

@end
