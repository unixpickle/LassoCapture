//
//  LCEventOverlay.h
//  LassoCapture
//
//  Created by Alex Nichol on 4/4/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Will provide an alternative to having one big NSWindow spanning multiple
 * screens which can stroke a path. Instead, this creates a separate NSWindow
 * for each display and uses LCMouseTap to capture mouse events.
 */
@interface LCEventOverlay : NSObject {
  NSArray * windows;
}

@property (nonatomic, strong) NSColor * color;

- (void)redraw:(CGPathRef)path;

@end
