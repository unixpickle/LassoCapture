//
//  LCLassoTool.h
//  LassoCapture
//
//  Created by Alex Nichol on 4/4/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "LCTool.h"
#import "LCMouseTap.h"
#import "LCEventOverlay.h"

@interface LCLassoTool : NSObject <LCTool, LCMouseTapDelegate> {
  LCMouseTap * mouseTap;
  LCEventOverlay * eventOverlay;
  
  CGMutablePathRef path;
  BOOL isTapping;
}

@end
