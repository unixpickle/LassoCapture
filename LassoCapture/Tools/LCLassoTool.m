//
//  LCLassoTool.m
//  LassoCapture
//
//  Created by Alex Nichol on 4/4/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "LCLassoTool.h"
#import "LCToolList.h"

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
}

- (void)cancelTool {
  [mouseTap cancel];
  [eventOverlay cancel];
  mouseTap = nil;
  eventOverlay = nil;
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
  [self.toolDelegate lcToolCancelled:self];
}

- (void)mouseTap:(id)sender movedToPoint:(NSPoint)point {
  if (!isTapping) return;
  CGPathAddLineToPoint(path, NULL, point.x, point.y);
  [eventOverlay redraw:path];
}

@end
