//
//  LCMouseTap.m
//  LassoCapture
//
//  Created by Alex Nichol on 4/4/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "LCMouseTap.h"

static CGEventRef mouse_event_callback(CGEventTapProxy proxy, CGEventType type, CGEventRef event, void * userData);

@interface LCMouseTap (Private)

- (void)handleEvent:(CGEventRef)evt type:(CGEventType)type;

@end

@implementation LCMouseTap

- (void)start {
  CGEventMask mask = CGEventMaskBit(kCGEventMouseMoved)
    | CGEventMaskBit(kCGEventLeftMouseDown)
    | CGEventMaskBit(kCGEventLeftMouseUp);
  eventTap = CGEventTapCreate(kCGHIDEventTap, kCGHeadInsertEventTap, kCGEventTapOptionDefault,
                              mask, mouse_event_callback, (__bridge void *)self);
  if (!eventTap) {
    NSLog(@"Couldn't create event tap!");
    exit(1);
  }
  
  runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0);
  CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, kCFRunLoopCommonModes);
  CGEventTapEnable(eventTap, true);

}

- (void)cancel {
  CFRunLoopRemoveSource(CFRunLoopGetCurrent(), runLoopSource, kCFRunLoopCommonModes);
  CFRelease(eventTap);
  CFRelease(runLoopSource);
}

#pragma mark - Private -

- (void)handleEvent:(CGEventRef)evt type:(CGEventType)type {
  NSPoint point = NSPointFromCGPoint(CGEventGetLocation(evt));
  if (type == kCGEventLeftMouseUp) {
    [self.delegate mouseTap:self mouseUp:point];
  } else if (type == kCGEventLeftMouseDown) {
    [self.delegate mouseTap:self mouseDown:point];
  } else if (type == kCGEventMouseMoved) {
    [self.delegate mouseTap:self movedToPoint:point];
  }
}

@end

static CGEventRef mouse_event_callback(CGEventTapProxy proxy, CGEventType type, CGEventRef event, void * userData) {
  LCMouseTap * tap = (__bridge LCMouseTap *)userData;
  [tap handleEvent:event type:type];
  return event;
}
