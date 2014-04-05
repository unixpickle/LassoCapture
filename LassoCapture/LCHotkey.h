//
//  LCHotkey.h
//  LassoCapture
//
//  Created by Alex Nichol on 4/4/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Carbon/Carbon.h>

typedef enum {
  LCHotkeyModifierCommand = cmdKey,
  LCHotkeyModifierOption = optionKey,
  LCHotkeyModifierControl = controlKey,
  LCHotkeyModifierShift = shiftKey
} LCHotkeyModifier;

@interface LCHotkey : NSObject {
  EventHotKeyRef hotKeyRef;
  UInt32 uid;
}

@property (readwrite) LCHotkeyModifier modifiers;
@property (readwrite) NSUInteger keyCode;
@property (nonatomic, weak) id target;
@property (readwrite) SEL selector;

+ (NSUInteger)keyCodeForChar:(NSString *)str;
- (void)startHooking;
- (void)stopHooking;

@end
