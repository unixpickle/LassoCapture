//
//  LCToolPickerWindow.m
//  LassoCapture
//
//  Created by Alex Nichol on 3/14/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "LCToolPickerWindow.h"
#import "LCToolList.h"

@implementation LCToolPickerWindow

- (id)initOnScreen:(NSScreen *)screen identifier:(NSString *)identifier {
  NSArray * cells = @[
                      [[LCToolPickerCell alloc] init],
                      [[LCToolPickerCell alloc] init],
                      [[LCToolPickerCell alloc] init]
                     ];
  [[cells[0] imageView] setImage:[NSImage imageNamed:@"1"]];
  [[cells[1] imageView] setImage:[NSImage imageNamed:@"2"]];
  [[cells[2] imageView] setImage:[NSImage imageNamed:@"3"]];
  [cells[0] setIdentifier:LCToolIdentifierNormal];
  [cells[1] setIdentifier:LCToolIdentifierLasso];
  [cells[2] setIdentifier:LCToolIdentifierPoly];
  
  CGFloat cellSize = kLCToolPickerWindowHeight - (kLCToolPickerViewOuterPadding * 2);
  CGFloat viewWidth = (cellSize * cells.count) +
    (kLCToolPickerViewInnerPadding * (cells.count - 1)) +
    (kLCToolPickerViewOuterPadding * 2);
  NSRect centerRect = NSMakeRect((screen.frame.size.width - viewWidth) / 2.0,
                   (screen.frame.size.height - kLCToolPickerWindowHeight) / 2.0,
                   viewWidth, kLCToolPickerWindowHeight);
  if ((self = [super initWithContentRect:centerRect
                 styleMask:NSBorderlessWindowMask
                   backing:NSBackingStoreBuffered
                   defer:NO
                  screen:screen])) {
    [self setOpaque:NO];
    self.backgroundColor = [NSColor clearColor];
    _view = [[LCToolPickerView alloc] initWithFrame:NSMakeRect(0, 0, viewWidth, kLCToolPickerWindowHeight)
                                              cells:cells
                                         identifier:identifier];
    self.contentView = _view;
    [self setLevel:CGShieldingWindowLevel()];
  }
  return self;
}

- (void)fadeOut {
  [[NSAnimationContext currentContext] setDuration:0.2];
  [self.animator setAlphaValue:0];
  [self performSelector:@selector(orderOut:) withObject:nil afterDelay:0.2];
}

@end
