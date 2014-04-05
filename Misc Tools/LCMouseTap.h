//
//  LCMouseTap.h
//  LassoCapture
//
//  Created by Alex Nichol on 4/4/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LCMouseTapDelegate

- (void)mouseTap:(id)sender mouseDown:(NSPoint)point;
- (void)mouseTap:(id)sender movedToPoint:(NSPoint)point;
- (void)mouseTap:(id)sender mouseUp:(NSPoint)point;

@end

/**
 * This provides an easy to use interface for catching mouse events
 * across multiple windows.
 */
@interface LCMouseTap : NSObject {
  CFRunLoopSourceRef runLoopSource;
  CFMachPortRef eventTap;
}

@property (nonatomic, weak) id<LCMouseTapDelegate> delegate;

- (void)start;
- (void)cancel;

@end
