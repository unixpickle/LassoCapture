//
//  LCLassoTool.m
//  LassoCapture
//
//  Created by Alex Nichol on 4/4/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "LCLassoTool.h"
#import "LCToolList.h"

@implementation LCLassoTool

+ (NSString *)identifier {
  return LCToolIdentifierLasso;
}

- (void)startTool {
  NSRect frame = NSZeroRect;
  for (NSScreen * s in [NSScreen screens]) {
    NSRect rect = s.frame;
    if (rect.origin.x < frame.origin.x) {
      frame.size.width += frame.origin.x - rect.origin.x;
      frame.origin.x = rect.origin.x;
    }
    if (rect.origin.y < frame.origin.y) {
      frame.size.height += frame.origin.y - rect.origin.y;
      frame.origin.y = rect.origin.y;
    }
    if (rect.origin.x + rect.size.width > frame.origin.x + frame.size.width) {
      frame.size.width = rect.origin.x + rect.size.width - frame.origin.x;
    }
    if (rect.origin.y + rect.size.height > frame.origin.y + frame.size.height) {
      frame.size.height = rect.origin.y + rect.size.height - frame.origin.y;
    }
  }
  
  
}

- (void)cancelTool {
  
}

@end
