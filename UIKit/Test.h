//
//  Test.h
//  UIKit
//
//  Created by 冯学仕 on 17/8/14.
//  Copyright © 2017年 rooten. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Test : NSObject

@property (nonatomic, retain) NSNumber *num;

@property (nonatomic, retain) NSNumber *value;

@property (nonatomic, retain) UIColor *color;

- (instancetype) initWithkey:(NSNumber *)num value:(NSNumber *)value color:(UIColor *)color;

@end
