//
//  LCDefaultTool.h
//  LassoCapture
//
//  Created by Alex Nichol on 4/4/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCTool.h"

@interface LCDefaultTool : NSObject <LCTool> {
  NSTask * task;
  NSString * savePath;
}

@end
