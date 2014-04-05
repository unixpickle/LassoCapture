//
//  LCPolyTool.h
//  LassoCapture
//
//  Created by Alex Nichol on 4/5/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCTool.h"
#import "LCMouseTap.h"
#import "LCEventOverlay.h"
#import "LCHotkey.h"

@interface LCPolyTool : NSObject <LCTool, LCMouseTapDelegate> {
  CGMutablePathRef path;
  
  BOOL hasStarted;
  CGPoint initialPoint;
  NSCursor * lastCursor;
  
  LCMouseTap * mouseTap;
  LCEventOverlay * eventOverlay;
  LCHotkey * cancelHotkey;
}

@end
