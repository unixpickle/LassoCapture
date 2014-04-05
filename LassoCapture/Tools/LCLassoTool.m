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
  mouseTap = [[LCMouseTap alloc] init];
  eventOverlay = [[LCEventOverlay alloc] init];
  
  mouseTap.delegate = self;
  [mouseTap start];
  
  [eventOverlay begin];
}

- (void)cancelTool {
  [mouseTap cancel];
  [eventOverlay cancel];
}

#pragma mark - Mouse Tap -

- (void)mouseTap:(id)sender mouseDown:(NSPoint)point {
  
}

- (void)mouseTap:(id)sender mouseUp:(NSPoint)point {
  
}

- (void)mouseTap:(id)sender movedToPoint:(NSPoint)point {
  
}

@end
