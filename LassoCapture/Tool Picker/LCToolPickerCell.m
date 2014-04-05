//
//  LCToolPickerCell.m
//  LassoCapture
//
//  Created by Alex Nichol on 3/14/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "LCToolPickerCell.h"

@implementation LCToolPickerCell

- (id)init {
  if ((self = [super init])) {
    _imageView = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, 1, 1)];
    [self addSubview:_imageView];
  }
  return self;
}

- (id)initWithFrame:(NSRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    NSRect inset = NSMakeRect(kLCToolPickerCellBevel, kLCToolPickerCellBevel,
                  frame.size.width - kLCToolPickerCellBevel * 2,
                  frame.size.height - kLCToolPickerCellBevel * 2);
    _imageView = [[NSImageView alloc] initWithFrame:inset];
    [self addSubview:self.imageView];
  }
  return self;
}

- (void)setFrame:(NSRect)frame {
  [super setFrame:frame];
  NSRect inset = NSMakeRect(kLCToolPickerCellBevel, kLCToolPickerCellBevel,
                frame.size.width - kLCToolPickerCellBevel * 2,
                frame.size.height - kLCToolPickerCellBevel * 2);
  self.imageView.frame = inset;
}

- (void)drawRect:(NSRect)dirtyRect {
  if (!self.selected) return;
  
  CGRect insetRect = CGRectInset(NSRectToCGRect(self.bounds),
                   kLCToolPickerCellBorderWidth,
                   kLCToolPickerCellBorderWidth);
  CGFloat innerRad = kLCToolPickerCellCornerRadius - kLCToolPickerCellBorderWidth;
  NSBezierPath * innerPath = [NSBezierPath bezierPathWithRoundedRect:NSRectFromCGRect(insetRect)
                                 xRadius:innerRad yRadius:innerRad];
  [[NSColor colorWithWhite:0 alpha:0.5] setFill];
  [innerPath fill];
  
  CGRect outerRect = CGRectInset(NSRectToCGRect(self.bounds),
                   kLCToolPickerCellBorderWidth / 2.0,
                   kLCToolPickerCellBorderWidth / 2.0);
  NSBezierPath * outerPath = [NSBezierPath bezierPathWithRoundedRect:NSRectFromCGRect(outerRect)
                                 xRadius:kLCToolPickerCellCornerRadius
                                 yRadius:kLCToolPickerCellCornerRadius];
  [outerPath setLineWidth:kLCToolPickerCellBorderWidth];
  [[NSColor whiteColor] setStroke];
  [outerPath stroke];
}

@end
