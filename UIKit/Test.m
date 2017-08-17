//
//  Test.m
//  UIKit
//
//  Created by 冯学仕 on 17/8/14.
//  Copyright © 2017年 rooten. All rights reserved.
//

#import "Test.h"

@implementation Test

- (instancetype) initWithkey:(NSNumber *)num value:(NSNumber *)value color:(UIColor *)color
{
    if (self = [super init]) {
        _num = num;
        _value = value;
        _color = color;
    }
    return self;
}

@end
