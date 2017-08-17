//
//  UIView+UIView_UIBzierPath.h
//  UIKit
//
//  Created by 冯学仕 on 17/8/12.
//  Copyright © 2017年 rooten. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Test.h"

typedef NS_ENUM(NSInteger , Graph) {
    VIEW_TAG_RECTANGLE  = 0,
    VIEW_TAG_ROUND      = 1
};

@interface UIView (UIView_UIBzierPath)

///UIBierPath画矩形：尺寸，线宽度，终点样式，拐点样式，斜接长度，是否线条绘画
- (void) drawRectangle:(CGRect) rect
                  linW:(CGFloat)lineW
               capStyl:(NSString *)capStyl
          joinLineStyl:(NSString *)joinLineStyl
          strokenColor:(UIColor *)strokenColor
             fillColor:(UIColor *)fillColor
                 graph:(Graph)graph;

///画弧
- (void) drawARC:(CGPoint)point
          radius:(CGFloat)radius
      startAngle:(CGFloat)start
        endAngle:(CGFloat)end
       clockwise:(BOOL)clock
       lineWidth:(CGFloat)lineW
         capStyl:(NSString *)capStyl
   joinLineStyle:(NSString *)joinStyl
    strokenColor:(UIColor *)strokenColor
       fillColor:(UIColor *)fillColor;

///画n边形
- (CAShapeLayer *) drawN:(NSMutableArray<NSValue *>*)points
  strokenColor:(UIColor *)strokenColor
     fillColor:(UIColor *)fillColor
     lineWidth:(CGFloat)lineW;

///画波纹
- (void) drawRipple:(CGPoint)start
             point1:(CGPoint)firstP
             point2:(CGPoint)secondP
             point3:(CGPoint)endP
          lineWidth:(CGFloat)lineW
            lineCap:(NSString *)lineCap
           lineJoin:(NSString *)lineJoin
       strokenColor:(UIColor *)strokenColor
          fillColor:(UIColor *)fillColor;

//动态绘制柱状
- (void) drawHistorgram:(CGPoint)startPoint
               endPoint:(CGPoint)endPoint
                  linew:(CGFloat)lineW
                  color:(UIColor *)lineColor
               duration:(float)duration;

///图形移动(point)
- (void) drawMoveAction:(CGRect)frame
        backgroundColor:(UIColor *)back
               position:(CGPoint)point
            anchorPoint:(CGPoint)anchorPoint
              fromValue:(CGPoint)fromValue
                toValue:(CGPoint)toValue
               duration:(float)duration
              keyPath_h:(NSString *)keyPath_h
              keyPaht_e:(NSString *)keyPath_e
                repeats:(float)repeats;

///图形移动（水平）
- (void) drawMoveAction:(CGRect)frame
        backgroundColor:(UIColor *)back
               position:(CGPoint)point
            anchorPoint:(CGPoint)anchorPoint
              fromValue:(float)fromValue
                toValue:(float)toValue
               duration:(float)duration
              keyPath_h:(NSString *)keyPath_h
              keyPaht_e:(NSString *)keyPath_e
                repeats:(float)repeats
           mediaTimming:(NSString *)mediaName;

///旋转
- (void)drawTranslationAction:(CGRect)frame
              backgroundColor:(UIColor *)back
                      keypath:(NSString *)keypath
                    fromValue:(float)fromValue
                      toValue:(float)toValue
                     duration:(float)duration
                  repeatCount:(float)repeatcount
                    keypath_e:(NSString *)keypath_e;

//画饼状图
- (void)drawPieCharts:(NSMutableArray<Test*>*)items
          centerPoint:(CGPoint)point
               radius:(CGFloat)radius;
@end
