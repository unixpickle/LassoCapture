//
//  LCEventOverlayView.h
//  LassoCapture
//
//  Created by Alex Nichol on 4/5/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LCEventOverlayView : NSView

@property (readwrite) CGPathRef path;

@property (readwrite) CGPoint currentPoint;
@property (readwrite) BOOL hasCurrentPoint;

@property (readwrite) NSPoint generalOffset;
@property (nonatomic, retain) NSColor * strokeColor;

@end
