//
//  LCEventOverlay.h
//  LassoCapture
//
//  Created by Alex Nichol on 4/4/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCMouseTap.h"

/**
 * Will provide an alternative to having one big NSWindow spanning multiple
 * screens which can stroke a path. Instead, this creates a separate NSWindow
 * for each display and splits up the graphics context path as needed.
 */
@interface LCEventOverlay : NSObject {
  NSArray * windows;
}

@property (nonatomic, strong) NSColor * color;

- (void)begin;
- (void)cancel;
- (void)redraw:(CGPathRef)path;

@end
