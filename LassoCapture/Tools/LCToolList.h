//
//  LCToolList.h
//  LassoCapture
//
//  Created by Alex Nichol on 4/4/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCTool.h"

#define LCToolIdentifierNormal @"normal"
#define LCToolIdentifierLasso @"lasso"
#define LCToolIdentifierPoly @"poly"

@interface LCToolList : NSObject

+ (id<LCTool>)toolWithIdentifier:(NSString *)identifier;

@end
