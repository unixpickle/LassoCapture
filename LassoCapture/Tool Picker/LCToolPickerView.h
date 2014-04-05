//
//  LCToolPickerView.h
//  LassoCapture
//
//  Created by Alex Nichol on 3/14/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LCToolPickerCell.h"

#define kLCToolPickerViewCornerRadius 22.0
#define kLCToolPickerViewOuterPadding 15.0
#define kLCToolPickerViewInnerPadding 4

@interface LCToolPickerView : NSView {
  NSArray * cells;
  NSInteger current;
}

- (id)initWithFrame:(NSRect)frameRect cells:(NSArray *)cells identifier:(NSString *)identifier;

- (void)goToNext;
- (void)goToLast;
- (LCToolPickerCell *)currentCell;

@end
