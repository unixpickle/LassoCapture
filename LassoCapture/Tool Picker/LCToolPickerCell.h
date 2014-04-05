//
//  LCToolPickerCell.h
//  LassoCapture
//
//  Created by Alex Nichol on 3/14/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define kLCToolPickerCellBorderWidth 3.0
#define kLCToolPickerCellCornerRadius 9.0
#define kLCToolPickerCellBevel 9.0

@interface LCToolPickerCell : NSView

@property (nonatomic, strong) NSString * identifier;
@property (readonly) NSImageView * imageView;
@property (readwrite) BOOL selected;

- (id)initWithFrame:(NSRect)frameRect;

@end
