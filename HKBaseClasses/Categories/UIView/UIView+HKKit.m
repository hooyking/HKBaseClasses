//
//  UIView+HKKit.m
//  HKBaseClasses
//
//  Created by hooyking on 2020/5/19.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import "UIView+HKKit.h"

typedef void(^HKAnimationCompletion)(void);

@interface HKAnimationBlockTarget : NSObject <CAAnimationDelegate>

@property (nonatomic, copy) HKAnimationCompletion completion;

- (instancetype)initWithBlock:(HKAnimationCompletion)block;

@end

@implementation HKAnimationBlockTarget

- (instancetype)initWithBlock:(HKAnimationCompletion)block {
    self = [super init];
    if (self) {
        self.completion = block;
    }
    return self;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (self.completion) {
        self.completion();
    }
}

@end

@implementation UIView (HKKit)

#pragma mark - 对view截图

- (UIImage *)snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (UIImage *)snapshotImageAfterScreenUpdates:(BOOL)afterUpdates {
    if (![self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)] || CGRectIsEmpty(self.bounds)) {
        return [self snapshotImage];
    }
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:afterUpdates];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (NSData *)snapshotPDF {
    CGRect bounds = self.bounds;
    NSMutableData *data = [NSMutableData data];
    CGDataConsumerRef consumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)data);
    CGContextRef context = CGPDFContextCreate(consumer, &bounds, NULL);
    CGDataConsumerRelease(consumer);
    if (!context) return nil;
    CGPDFContextBeginPage(context, NULL);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self.layer renderInContext:context];
    CGPDFContextEndPage(context);
    CGPDFContextClose(context);
    CGContextRelease(context);
    return data;
}

#pragma mark - 对视图的处理

- (void)removeAllSubviews {
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

- (void)drawCornerWithRect:(CGRect)rect
                    corner:(UIRectCorner)corner
                     radio:(CGFloat)radio {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                               byRoundingCorners:corner
                                                     cornerRadii:CGSizeMake(radio, radio)];
    CAShapeLayer *masklayer = [[CAShapeLayer alloc] init];
    masklayer.frame = self.bounds;
    masklayer.path = path.CGPath;
    self.layer.mask = masklayer;
//    self.layer.shouldRasterize = YES;//光栅化
//    self.layer.rasterizationScale = [UIScreen mainScreen].scale;//是针对retian屏幕的，防止滑动模糊
}

- (void)drawShadowWithColor:(UIColor *)color
                     offset:(CGSize)offset
                    opacity:(float)opacity
               shadowRadius:(CGFloat)shadowRadius
          layerCornerRadius:(CGFloat)layerCornerRadius {
    
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = shadowRadius > 0 ? shadowRadius : 3;
    self.layer.cornerRadius = layerCornerRadius;
//    self.layer.shouldRasterize = YES;//光栅化
//    self.layer.rasterizationScale = [UIScreen mainScreen].scale;//是针对retian屏幕的，防止滑动模糊
}

- (CGPoint)convertPoint:(CGPoint)point toViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertPoint:point toWindow:nil];
        } else {
            return [self convertPoint:point toView:nil];
        }
    }
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if ((!from || !to) || (from == to)) return [self convertPoint:point toView:view];
    point = [self convertPoint:point toView:from];
    point = [to convertPoint:point fromWindow:from];
    point = [view convertPoint:point fromView:to];
    return point;
}

- (CGPoint)convertPoint:(CGPoint)point fromViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertPoint:point fromWindow:nil];
        } else {
            return [self convertPoint:point fromView:nil];
        }
    }
    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) return [self convertPoint:point fromView:view];
    point = [from convertPoint:point fromView:view];
    point = [to convertPoint:point fromWindow:from];
    point = [self convertPoint:point fromView:to];
    return point;
}

- (CGRect)convertRect:(CGRect)rect toViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect toWindow:nil];
        } else {
            return [self convertRect:rect toView:nil];
        }
    }
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if (!from || !to) return [self convertRect:rect toView:view];
    if (from == to) return [self convertRect:rect toView:view];
    rect = [self convertRect:rect toView:from];
    rect = [to convertRect:rect fromWindow:from];
    rect = [view convertRect:rect fromView:to];
    return rect;
}

- (CGRect)convertRect:(CGRect)rect fromViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect fromWindow:nil];
        } else {
            return [self convertRect:rect fromView:nil];
        }
    }
    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) return [self convertRect:rect fromView:view];
    rect = [from convertRect:rect fromView:view];
    rect = [to convertRect:rect fromWindow:from];
    rect = [self convertRect:rect fromView:to];
    return rect;
}

- (void)addProgressHUDCancelBtnWithClickedBlock:(void(^)(void))clickedBlock {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"X" forState:UIControlStateNormal];
    btn.titleLabel.font = kFontRegular(12);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.4];
    [btn addBlockForControlEvents:UIControlEventTouchDown block:^(id  _Nonnull sender) {
        if (clickedBlock) {
            clickedBlock();
        }
    }];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(16);
        make.right.top.equalTo(self);
    }];
}

#pragma mark - 动画

- (void)fadeinAnimationWithDuration:(NSTimeInterval)duration completion:(void(^)(void))completion {
    CAGradientLayer *contentLayer = (CAGradientLayer *)self.layer;
    CABasicAnimation *showViewAnn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    showViewAnn.fromValue = [NSNumber numberWithFloat:0.0];
    showViewAnn.toValue = [NSNumber numberWithFloat:1.0];
    showViewAnn.duration = duration;
    HKAnimationBlockTarget *target = [[HKAnimationBlockTarget alloc] initWithBlock:completion];
    showViewAnn.delegate = target;
    showViewAnn.fillMode = kCAFillModeForwards;
    showViewAnn.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    showViewAnn.removedOnCompletion = NO;
    [contentLayer addAnimation:showViewAnn forKey:nil];
    
}

- (void)fadeoutAnimationWithDuration:(NSTimeInterval)duration completion:(void(^)(void))completion {
    CAGradientLayer *contentLayer = (CAGradientLayer *)self.layer;
    CABasicAnimation *showViewAnn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    showViewAnn.fromValue = [NSNumber numberWithFloat:1.0];
    showViewAnn.toValue = [NSNumber numberWithFloat:0.0];
    showViewAnn.duration = duration;
    HKAnimationBlockTarget *target = [[HKAnimationBlockTarget alloc] initWithBlock:completion];
    showViewAnn.delegate = target;
    showViewAnn.fillMode = kCAFillModeForwards;
    showViewAnn.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    showViewAnn.removedOnCompletion = NO;
    [contentLayer addAnimation:showViewAnn forKey:nil];
}

- (void)expandAnimationWithDuration:(NSTimeInterval)duration completion:(void(^)(void))completion {
    CAGradientLayer *contentLayer = (CAGradientLayer *)self.layer;
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 1)];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    scaleAnimation.duration = duration;
    HKAnimationBlockTarget *target = [[HKAnimationBlockTarget alloc] initWithBlock:completion];
    scaleAnimation.delegate = target;
    scaleAnimation.cumulative = NO;
    scaleAnimation.repeatCount = 1;
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    [scaleAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [contentLayer addAnimation: scaleAnimation forKey:nil];
}

- (void)witherAnimationWithDuration:(NSTimeInterval)duration completion:(void(^)(void))completion {
    CAGradientLayer *contentLayer = (CAGradientLayer *)self.layer;
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 1)];
    scaleAnimation.duration = duration;
    HKAnimationBlockTarget *target = [[HKAnimationBlockTarget alloc] initWithBlock:completion];
    scaleAnimation.delegate = target;
    scaleAnimation.repeatCount = 1;
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    [scaleAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [contentLayer addAnimation: scaleAnimation forKey:nil];
}

- (void)rotationAnimationByAlwaysWithDuration:(NSTimeInterval)duration clockwise:(BOOL)clockwise {
    CAGradientLayer *contentLayer = (CAGradientLayer *)self.layer;
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    if (clockwise) {
        rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2];
    } else {
        rotationAnimation.fromValue = [NSNumber numberWithFloat:M_PI*2];
    }
    rotationAnimation.repeatCount = HUGE_VAL;
    rotationAnimation.cumulative = YES;
    rotationAnimation.duration = duration;
    [contentLayer addAnimation:rotationAnimation forKey:nil];
}

- (void)rotationAnimationWithDuration:(NSTimeInterval)duration
                            clockwise:(BOOL)clockwise
                           completion:(void(^)(void))completion {
    
    CAGradientLayer *contentLayer = (CAGradientLayer *)self.layer;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    if (clockwise) {
        animation.fromValue = [NSNumber numberWithFloat:M_PI];
        animation.toValue = [NSNumber numberWithFloat:M_PI*2];
    } else {
        animation.fromValue = [NSNumber numberWithFloat:M_PI*2];
        animation.toValue = [NSNumber numberWithFloat:M_PI];
    }
 
    CABasicAnimation *showViewAnn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    showViewAnn.fromValue = [NSNumber numberWithFloat:0.0];
    showViewAnn.toValue = [NSNumber numberWithFloat:1.0];

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = duration;
    group.repeatCount = 1;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [group setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [group setAnimations:@[animation,showViewAnn]];
    HKAnimationBlockTarget *target = [[HKAnimationBlockTarget alloc] initWithBlock:completion];
    group.delegate = target;
    [contentLayer addAnimation:group forKey:nil];
}

#pragma mark - 查询view相关对象

- (UIViewController *)viewController {
    UIResponder *responder = self;
    //循环获取下一个响应者,直到响应者是一个UIViewController类的一个对象为止,然后返回该对象.
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}

#pragma mark - view的快捷frame相关属性设置

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end
