//
//  LCScreenshotCropper.h
//  LassoCapture
//
//  Created by Alex Nichol on 4/5/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCScreenshotCropper : NSObject

+ (NSImage *)cropScreenshotToPath:(CGPathRef)path;

@end
