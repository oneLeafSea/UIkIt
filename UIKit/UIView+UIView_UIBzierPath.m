//
//  UIView+UIView_UIBzierPath.m
//  UIKit
//
//  Created by 冯学仕 on 17/8/12.
//  Copyright © 2017年 rooten. All rights reserved.
//

#import "UIView+UIView_UIBzierPath.h"
#import "Test.h"

@implementation UIView (UIView_UIBzierPath)

///根据枚举值确定当前操作视图：大小，线宽，终点样式，拐弯样式，线的颜色，内部颜色，枚举
- (void) drawRectangle:(CGRect) rect
                  linW:(CGFloat)lineW
               capStyl:(NSString *)capStyl
          joinLineStyl:(NSString *)joinLineStyl
          strokenColor:(UIColor *)strokenColor
             fillColor:(UIColor *)fillColor
                 graph:(Graph)graph
{

    UIBezierPath *path;
    switch (graph) {
        case VIEW_TAG_RECTANGLE:
            path =  [UIBezierPath bezierPathWithRect:rect];
            break;
        case VIEW_TAG_ROUND:
            path = [UIBezierPath bezierPathWithOvalInRect:rect];
        default:
            break;
    }
        CAShapeLayer *shapelayer = [CAShapeLayer layer] ;
        shapelayer.lineWidth = lineW;
        shapelayer.lineCap   = capStyl;
        shapelayer.lineJoin  = joinLineStyl;
        shapelayer.strokeColor = strokenColor.CGColor;
        shapelayer.path = path.CGPath;
        shapelayer.fillColor = fillColor.CGColor;
        [self.layer addSublayer:shapelayer];
   
    
}

///画弧(点位，半径，启始角度，结束角度，是否顺时针，线宽，终点样式，拐点样式，线颜色，填充颜色)
- (void) drawARC:(CGPoint)point
          radius:(CGFloat)radius
      startAngle:(CGFloat)start
        endAngle:(CGFloat)end
       clockwise:(BOOL)clock
       lineWidth:(CGFloat)lineW
         capStyl:(NSString *)capStyl
   joinLineStyle:(NSString *)joinStyl
    strokenColor:(UIColor *)strokenColor
       fillColor:(UIColor *)fillColor
{
    UIBezierPath* aPath = [UIBezierPath bezierPathWithArcCenter:point
                                                         radius:radius
                                                     startAngle:start
                                                       endAngle:end
                                                      clockwise:clock];
    
    CAShapeLayer *shaperLayer = [CAShapeLayer layer];
    shaperLayer.path = aPath.CGPath;
    shaperLayer.lineWidth = lineW;
    shaperLayer.lineCap   = capStyl;
    shaperLayer.lineJoin  = joinStyl;
    shaperLayer.strokeColor = strokenColor.CGColor;
    shaperLayer.fillColor   = fillColor.CGColor;
    [self.layer addSublayer:shaperLayer];

}

/// 绘制n边形
- (CAShapeLayer *) drawN:(NSMutableArray<NSValue *>*)points
  strokenColor:(UIColor *)strokenColor
     fillColor:(UIColor *)fillColor
     lineWidth:(CGFloat)lineW
{
    if (points.count == 0) return nil;
    UIBezierPath *path = [[UIBezierPath alloc] init];
    for (int i=0; i<points.count; i++) {
        if (i == 0) {
            [path moveToPoint:points[0].CGPointValue];
        } else {
            [path addLineToPoint:points[i].CGPointValue];
        }
    }
    [path closePath];
    CAShapeLayer *shaperLayer = [CAShapeLayer layer];
    shaperLayer.path = path.CGPath;
    shaperLayer.strokeColor = strokenColor.CGColor;
    shaperLayer.fillColor   = fillColor.CGColor;
    shaperLayer.lineWidth   = lineW;
    [self.layer addSublayer:shaperLayer];
    return shaperLayer;
}

///绘制波纹(两峰)
- (void) drawRipple:(CGPoint)start
             point1:(CGPoint)firstP
             point2:(CGPoint)secondP
             point3:(CGPoint)endP
          lineWidth:(CGFloat)lineW
            lineCap:(NSString *)lineCap
           lineJoin:(NSString *)lineJoin
       strokenColor:(UIColor *)strokenColor
          fillColor:(UIColor *)fillColor
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:start];
    [path addCurveToPoint:firstP controlPoint1:secondP controlPoint2:endP];
    CAShapeLayer *shaperLayer = [CAShapeLayer layer];
    shaperLayer.path = path.CGPath;
    shaperLayer.strokeColor = strokenColor.CGColor;
    shaperLayer.fillColor   = fillColor.CGColor;
    shaperLayer.lineWidth   = lineW;
    [self.layer addSublayer:shaperLayer];
}

///柱状图动画(起始点，终点，宽度,颜色，间隔)：通过strokenEnd路径控制动画中移动
- (void) drawHistorgram:(CGPoint)startPoint
               endPoint:(CGPoint)endPoint
                  linew:(CGFloat)lineW
                  color:(UIColor *)lineColor
               duration:(float)duration
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    CAShapeLayer *shapeLine = [[CAShapeLayer alloc]init];
    shapeLine.strokeColor = lineColor.CGColor;
    shapeLine.lineWidth = lineW;
    [self.layer addSublayer:shapeLine];
    shapeLine.path = path.CGPath;
    [CATransaction begin];
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 2.0;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = @0.0f;
    pathAnimation.toValue   = @1.0f;
    [shapeLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    shapeLine.strokeEnd = 1.0;
    [CATransaction commit];
}

///画饼状图(items总度要达到360，没有为他设置空白区背景)
- (void)drawPieCharts:(NSMutableArray<Test*>*)items
          centerPoint:(CGPoint)point
               radius:(CGFloat)radius
{
    for (int i=0; i<items.count; i++) {
        Test *test = items[i];
        NSNumber *num = test.num;
        NSNumber *value = test.value;
        UIColor  *color = test.color;
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:point radius:radius startAngle:num.floatValue endAngle:value.floatValue clockwise:YES];
        [path addLineToPoint:point];
        CAShapeLayer *shapelayer = [[CAShapeLayer alloc] init];
        shapelayer.path = path.CGPath;
        shapelayer.fillColor = color.CGColor;
        [self.layer addSublayer:shapelayer];
    }
}



///画移动动画(anchorPoint:苗点：默认（0.5，0.5）范围（0，1）)(keyPath_h不能胡乱取值)
///参数（尺寸，颜色，相对父视图位置，相对自身位置，启始位置，结束位置，时长，key1，key2）
- (void) drawMoveAction:(CGRect)frame
        backgroundColor:(UIColor *)back
               position:(CGPoint)point
            anchorPoint:(CGPoint)anchorPoint
              fromValue:(CGPoint)fromValue
                toValue:(CGPoint)toValue
               duration:(float)duration
              keyPath_h:(NSString *)keyPath_h
              keyPaht_e:(NSString *)keyPath_e
                repeats:(float)repeats
{
    CALayer *layer = [[CALayer alloc] init];
    layer.frame = frame;
    layer.backgroundColor = back.CGColor;
    layer.position = point;
    layer.anchorPoint = anchorPoint;
    [self.layer addSublayer:layer];
    [CATransaction begin];
    CABasicAnimation *annimation = [CABasicAnimation animationWithKeyPath:keyPath_h];
    annimation.fromValue = [NSValue valueWithCGPoint:fromValue];
    annimation.toValue = [NSValue valueWithCGPoint:toValue];
    annimation.duration = duration;
    annimation.repeatCount = repeats;
    [layer addAnimation:annimation forKey:keyPath_e];
    [CATransaction commit];
}

///画移动动画(anchorPoint:苗点：默认（0.5，0.5）范围（0，1）)(keyPath_h不能胡乱取值)
///参数（尺寸，颜色，相对父视图位置，相对自身位置，启始位置，结束位置，时长，key1，key2）
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
           mediaTimming:(NSString *)mediaName
{
    CALayer *layer = [[CALayer alloc] init];
    layer.frame = frame;
    layer.backgroundColor = back.CGColor;
    layer.position = point;
    layer.anchorPoint = anchorPoint;
    [self.layer addSublayer:layer];
    [CATransaction begin];
    CABasicAnimation *annimation = [CABasicAnimation animationWithKeyPath:keyPath_h];
    annimation.fromValue = @(fromValue);
    annimation.toValue = @(toValue);
    annimation.timingFunction = [CAMediaTimingFunction functionWithName:mediaName];
    annimation.duration = duration;
    annimation.repeatCount = repeats;
    [layer addAnimation:annimation forKey:keyPath_e];
    [CATransaction commit];
}

///画旋转动画(缩放动画)
- (void)drawTranslationAction:(CGRect)frame
              backgroundColor:(UIColor *)back
                      keypath:(NSString *)keypath
                    fromValue:(float)fromValue
                      toValue:(float)toValue
                     duration:(float)duration
                  repeatCount:(float)repeatcount
                    keypath_e:(NSString *)keypath_e
{
    CALayer *layer = [[CALayer alloc] init];
    layer.frame=frame;
    layer.backgroundColor = back.CGColor;
    [self.layer addSublayer:layer];
    [CATransaction begin];
    CABasicAnimation *annimation = [CABasicAnimation animationWithKeyPath:keypath];
    annimation.fromValue = [NSNumber numberWithFloat:fromValue];
    annimation.toValue   = [NSNumber numberWithFloat:toValue];
    annimation.duration  = duration;
    annimation.repeatCount = repeatcount;
    [layer addAnimation:annimation forKey:keypath_e];
    [CATransaction commit];
}




@end
