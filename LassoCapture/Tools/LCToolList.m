//
//  LCToolList.m
//  LassoCapture
//
//  Created by Alex Nichol on 4/4/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "LCToolList.h"
#import "LCDefaultTool.h"
#import "LCLassoTool.h"
#import "LCPolyTool.h"

@implementation LCToolList

+ (id<LCTool>)toolWithIdentifier:(NSString *)identifier {
  NSDictionary * dictionary = @{LCToolIdentifierNormal: [LCDefaultTool class],
                                LCToolIdentifierLasso: [LCLassoTool class],
                                LCToolIdentifierPoly: [LCPolyTool class]};
  return [[dictionary[identifier] alloc] init];
}

@end
