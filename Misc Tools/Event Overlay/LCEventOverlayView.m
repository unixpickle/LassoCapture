//
//  LCEventOverlayView.m
//  LassoCapture
//
//  Created by Alex Nichol on 4/5/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "LCEventOverlayView.h"

@implementation LCEventOverlayView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
      
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
	[super drawRect:dirtyRect];
  if (!self.path) return;
	
  CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
  CGContextClearRect(context, NSRectToCGRect(self.bounds));
  
  // translate the path
  CGContextSaveGState(context);
  CGContextSetLineWidth(context, 5);
  CGContextSetLineCap(context, kCGLineCapRound);
  CGContextSetLineJoin(context, kCGLineJoinRound);
  CGContextBeginPath(context);
  CGContextTranslateCTM(context, -self.generalOffset.x, -self.generalOffset.y);
  CGContextAddPath(context, self.path);
  if (self.hasCurrentPoint) {
    CGContextAddLineToPoint(context, self.currentPoint.x, self.currentPoint.y);
  }
  CGContextSetStrokeColorWithColor(context, [self.strokeColor CGColor]);
  CGContextStrokePath(context);
  CGContextRestoreGState(context);
}

@end
