//
//  LCScreenshotCropper.m
//  LassoCapture
//
//  Created by Alex Nichol on 4/5/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "LCScreenshotCropper.h"
#import "ANImageBitmapRep.h"

@interface LCScreenshotCropper (Private)

+ (CGFloat)totalScreenScale;

@end

@implementation LCScreenshotCropper

+ (NSImage *)cropScreenshotToPath:(CGPathRef)path {
  CFArrayRef windows = CGWindowListCreate(kCGWindowListOptionOnScreenOnly, 0);
	CGImageRef screenShot = CGWindowListCreateImageFromArray(CGRectInfinite, windows, kCGWindowImageDefault);
  NSSize size = NSMakeSize(CGImageGetWidth(screenShot), CGImageGetHeight(screenShot));
  
  // calculate the scale
  CGFloat scale = [self.class totalScreenScale];
  
  ANImageBitmapRep * dest = [[ANImageBitmapRep alloc] initWithSize:BMPointMake((long)size.width, (long)size.height)];
  CGContextSaveGState(dest.context);
  CGContextBeginPath(dest.context);
  
  CGContextScaleCTM(dest.context, scale, scale);
  CGContextAddPath(dest.context, path);
  CGContextScaleCTM(dest.context, 1.0/scale, 1.0/scale);
  CGContextClip(dest.context);
  CGContextDrawImage(dest.context, CGRectMake(0, 0, size.width, size.height), screenShot);
  CGContextRestoreGState(dest.context);
  CGImageRelease(screenShot);
  
  [dest setNeedsUpdate:YES];
  CGRect boundingBox = CGPathGetBoundingBox(path);
  boundingBox.size.width *= scale;
  boundingBox.size.height *= scale;
  boundingBox.origin.x *= scale;
  boundingBox.origin.y *= scale;
  CGImageRef img = [dest croppedImageWithFrame:boundingBox];
  NSImage * final = [[NSImage alloc] initWithCGImage:img
                                                size:NSMakeSize(CGImageGetWidth(img),
                                                                CGImageGetHeight(img))];
  
  return final;
}

#pragma mark - Private -

+ (CGFloat)totalScreenScale {
  for (NSScreen * s in [NSScreen screens]) {
    if (s.backingScaleFactor != 1) {
      return s.backingScaleFactor;
    }
  }
  return 1.0;
}

@end
