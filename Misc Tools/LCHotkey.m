//
//  LCHotkey.m
//  LassoCapture
//
//  Created by Alex Nichol on 4/4/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "LCHotkey.h"

static OSStatus keyboard_hot_key(EventHandlerCallRef nextHandler, EventRef anEvent, void * userData);
static NSMutableDictionary * hotkeys = nil;
static NSInteger hkUid = 0;

@interface LCHotkey (Private)

+ (void)installHook;
+ (LCHotkey *)hotkeyForIdentifier:(NSInteger)identifier;
+ (void)registerHotkey:(LCHotkey *)hk forIdentifier:(NSInteger)identifier;
- (void)handleHotkey;

@end

@implementation LCHotkey

+ (NSUInteger)keyCodeForChar:(NSString *)str {
  NSDictionary * map = @{
    @"F": @(3),
    @"Q": @(12),
    @"4": @(21),
    @"H": @(4),
    @"G": @(5),
    @"W": @(13),
    @"6": @(22),
    @"Z": @(6),
    @"O": @(31),
    @"E": @(14),
    @"K": @(40),
    @"5": @(23),
    @"X": @(7),
    @"C": @(8),
    @"R": @(15),
    @"U": @(32),
    @"Left Arrow": @(123),
    @"V": @(9),
    @"Y": @(16),
    @"9": @(25),
    @"Delete": @(51),
    @"I": @(34),
    @"T": @(17),
    @"Right Arrow": @(124),
    @"7": @(26),
    @"P": @(35),
    @"1": @(18),
    @"Return": @(36),
    @"2": @(19),
    @"Down Arrow": @(125),
    @"8": @(28),
    @"N": @(45),
    @"L": @(37),
    @"M": @(46),
    @"0": @(29),
    @"Up Arrow": @(126),
    @"J": @(38),
    @"Space": @(49),
    @"A": @(0),
    @"S": @(1),
    @"B": @(11),
    @"D": @(2),
    @"3": @(20),
    @"Tab": @(0x30)
  };
  return [map[str] intValue];
}

- (void)startHooking {
  NSAssert(!hotKeyRef, @"Cannot re-call -startHooking");
  [self.class installHook];
  
  uid = (UInt32)hkUid++;
  
  EventHotKeyID hkId;
  hkId.signature = 'mnky'; // sign ANKeyEvent
  hkId.id = uid;
  
	RegisterEventHotKey((UInt32)self.keyCode, (UInt32)self.modifiers, hkId,
                      GetApplicationEventTarget(), 0, &hotKeyRef);
  [self.class registerHotkey:self forIdentifier:uid];
}

- (void)stopHooking {
  NSAssert(hotKeyRef, @"Cannot re-call -stopHooking");
  if (!hotKeyRef) return;
  UnregisterEventHotKey(hotKeyRef);
  hotKeyRef = NULL;
  [self.class registerHotkey:nil forIdentifier:uid];
}

#pragma mark - Private -

+ (void)installHook {
  static BOOL configured = NO;
  if (configured) return;
  configured = YES;
  
  EventTypeSpec eventType;
  eventType.eventClass = kEventClassKeyboard;
  eventType.eventKind = kEventHotKeyPressed;
  InstallApplicationEventHandler(&keyboard_hot_key, 1, &eventType, NULL, NULL);
}

+ (LCHotkey *)hotkeyForIdentifier:(NSInteger)identifier {
  if (!hotkeys) hotkeys = [[NSMutableDictionary alloc] init];
  return hotkeys[@(identifier)];
}

+ (void)registerHotkey:(LCHotkey *)hk forIdentifier:(NSInteger)identifier {
  if (!hotkeys) hotkeys = [[NSMutableDictionary alloc] init];
  if (!hk) [hotkeys removeObjectForKey:@(identifier)];
  else hotkeys[@(identifier)] = hk;
}

- (void)handleHotkey {
  if (!self.target) return;
  NSMethodSignature * sig = [self.target methodSignatureForSelector:self.selector];
  NSInvocation * inv = [NSInvocation invocationWithMethodSignature:sig];
  [inv setTarget:self.target];
  [inv setSelector:self.selector];
  [inv invoke];
}

@end

static OSStatus keyboard_hot_key(EventHandlerCallRef nextHandler, EventRef anEvent, void * userData) {
	EventHotKeyID hkRef;
  GetEventParameter(anEvent,
                    kEventParamDirectObject,
                    typeEventHotKeyID,
                    NULL,
                    sizeof(hkRef),
                    NULL,
                    &hkRef);
  LCHotkey * hk = [LCHotkey hotkeyForIdentifier:(NSInteger)hkRef.id];
  [hk handleHotkey];
  return noErr;
}
