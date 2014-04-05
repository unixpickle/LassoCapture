//
//  LCToolPickerWindow.h
//  LassoCapture
//
//  Created by Alex Nichol on 3/14/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LCToolPickerView.h"

#define kLCToolPickerWindowHeight 140.0

@interface LCToolPickerWindow : NSWindow

@property (readonly) LCToolPickerView * view;

- (id)initOnScreen:(NSScreen *)screen identifier:(NSString *)identifier;
- (void)fadeOut;

@end
