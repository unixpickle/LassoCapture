//
//  LCTool.h
//  LassoCapture
//
//  Created by Alex Nichol on 4/4/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LCToolDelegate

- (void)lcTool:(id)sender savedImage:(NSImage *)image;
- (void)lcToolCancelled:(id)sender;

@end

@protocol LCTool <NSObject>

@property (nonatomic, weak) id<LCToolDelegate> toolDelegate;

+ (NSString *)identifier;
- (void)startTool;
- (void)cancelTool;

@end
