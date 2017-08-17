//
//  ViewController.m
//  UIKit
//
//  Created by 冯学仕 on 17/8/12.
//  Copyright © 2017年 rooten. All rights reserved.
//

#import "ViewController.h"
#import "TestView.h"
#import "UIView+UIView_UIBzierPath.h"
#import "Test.h"

@interface ViewController ()<CAAnimationDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    TestView *test = [[TestView alloc] initWithFrame:self.view.frame];
//    test.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:test];
    self.view.backgroundColor = [UIColor whiteColor];
    [self test];
}

- (void) test {
  
    float from1 = 0;
    float from2 = M_PI /2;
    float to1 = M_PI /2;
    float to2 = M_PI*2 ;
    NSNumber *num1 = [NSNumber numberWithFloat:from1];
    NSNumber *num2 = [NSNumber numberWithFloat:from2];
    NSNumber *num3 = [NSNumber numberWithFloat:to1];
    NSNumber *num4 = [NSNumber numberWithFloat:to2];
    
    Test *test1 = [[Test alloc] initWithkey:num1 value:num3 color:[UIColor redColor]];
    Test *test2 = [[Test alloc] initWithkey:num2 value:num4 color:[UIColor blueColor]];
    NSMutableArray <Test *>* array = [[NSMutableArray alloc] init];
    [array addObject:test1];
    [array addObject:test2];
    
    [self.view drawPieCharts:array centerPoint:CGPointMake(150, 200) radius:100];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
