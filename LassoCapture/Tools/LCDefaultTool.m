//
//  LCDefaultTool.m
//  LassoCapture
//
//  Created by Alex Nichol on 4/4/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "LCDefaultTool.h"
#import "LCToolList.h"

@interface LCDefaultTool (Private)

- (void)handleTerminate;

@end

@implementation LCDefaultTool

@synthesize toolDelegate;

+ (NSString *)identifier {
  return LCToolIdentifierNormal;
}

- (void)startTool {
  task = [[NSTask alloc] init];
  savePath = [NSTemporaryDirectory() stringByAppendingFormat:@"%x.png", arc4random()];
  [task setLaunchPath:@"/usr/sbin/screencapture"];
  [task setArguments:@[@"-i", savePath]];
  __weak LCDefaultTool * weakSelf = self;
  [task setTerminationHandler:^(NSTask * t) {
    [weakSelf handleTerminate];
  }];
  [task launch];
}

- (void)cancelTool {
  NSTask * aTask = task;
  task = nil;
  [aTask terminate];
}

#pragma mark - Private -

- (void)handleTerminate {
  if (!task) return;
  if (![[NSFileManager defaultManager] fileExistsAtPath:savePath]) {
    return [self.toolDelegate lcToolCancelled:self];
  }
  NSImage * image = [[NSImage alloc] initWithContentsOfFile:savePath];
  [[NSFileManager defaultManager] removeItemAtPath:savePath error:nil];
  [self.toolDelegate lcTool:self savedImage:image];
}

@end
