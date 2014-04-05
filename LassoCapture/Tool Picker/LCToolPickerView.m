//
//  LCToolPickerView.m
//  LassoCapture
//
//  Created by Alex Nichol on 3/14/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "LCToolPickerView.h"

@implementation LCToolPickerView

- (id)initWithFrame:(NSRect)frameRect cells:(NSArray *)_cells identifier:(NSString *)identifier {
  if ((self = [super initWithFrame:frameRect])) {
    cells = _cells;
    
    // here, layout the cells
    CGFloat cellSize = frameRect.size.height - (kLCToolPickerViewOuterPadding * 2);
    NSRect cellRect = NSMakeRect(kLCToolPickerViewOuterPadding,
                   kLCToolPickerViewOuterPadding,
                   cellSize, cellSize);
    for (LCToolPickerCell * cell in cells) {
      cell.frame = cellRect;
      [self addSubview:cell];
      
      cellRect.origin.x += cellSize + kLCToolPickerViewInnerPadding;
    }
    
    for (int i = 0; i < cells.count; i++) {
      if ([[cells[i] identifier] isEqualToString:identifier]) {
        current = i;
      }
    }
    
    [cells[0] setSelected:YES];
    [cells[0] setNeedsDisplay:YES];
  }
  return self;
}

- (void)goToNext {
  [cells[current] setSelected:NO];
  [cells[current] setNeedsDisplay:YES];
  if ((++current) >= cells.count) {
    current = 0;
  }
  [cells[current] setSelected:YES];
  [cells[current] setNeedsDisplay:YES];
}

- (void)goToLast {
  [cells[current] setSelected:NO];
  [cells[current] setNeedsDisplay:YES];
  if ((--current) < 0) {
    current = cells.count - 1;
  }
  [cells[current] setSelected:YES];
  [cells[current] setNeedsDisplay:YES];
}

- (LCToolPickerCell *)currentCell {
  return cells[current];
}

- (void)drawRect:(NSRect)dirtyRect {
  CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
  CGContextClearRect(context, NSRectToCGRect(self.bounds));
  
  NSBezierPath * path = [NSBezierPath bezierPathWithRoundedRect:self.bounds
                              xRadius:kLCToolPickerViewCornerRadius
                              yRadius:kLCToolPickerViewCornerRadius];
  [[NSColor colorWithWhite:0 alpha:0.5] setFill];
  [path fill];
}

@end
