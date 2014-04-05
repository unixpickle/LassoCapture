//
//  LC1mage.h
//  LassoCapture
//
//  Created by Alex Nichol on 4/5/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ LC1mageCallback)(NSError * err, NSURL * theURL);

@interface LC1mage : NSObject <NSURLConnectionDelegate>

+ (void)startUpload:(NSImage *)image completed:(LC1mageCallback)cb;

@end
