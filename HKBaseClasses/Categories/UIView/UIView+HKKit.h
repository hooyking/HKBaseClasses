//
//  UIView+HKKit.h
//  HKBaseClasses
//
//  Created by hooyking on 2020/5/19.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HKKit)

#pragma mark - 对view截图

/**
 view的截图（返回image）
 
 @return 返回快照image
 */
- (UIImage *)snapshotImage;

/**
 view的截图（返回image）
 
 @discussion 使用while循环连续截屏100次webview有人发现崩溃为EXE_BAD_ACCESS，
 原因是afterScreenUpdates设置为了YES.为什么会崩溃呢?因为设置为YES后,这些方法会等在view update结束再执行,如果在update结束前view被release了,会出现找不到view的问题.所以需要设置为NO.
 
 @param afterUpdates 动画是否延迟
 
 @return 返回快照image
 */
- (UIImage *)snapshotImageAfterScreenUpdates:(BOOL)afterUpdates;

/**
 view的截图，PDF格式
 
 @discussion 保存到本地
 方法createFileAtPath: contents: attributes:使用NSFileManager保存，需要判断路径是否存在，不存在先创建目录（方法createDirectoryAtPath: withIntermediateDirectories: attributes: error:），BOOL isDirectory;if (![fileManger fileExistsAtPath:path isDirectory:&isDirectory]) {}，此方法判断目录是否存在。
 方法writeToFile: atomically:不用判断路径，但是需要使用方法fileExistsAtPath:判断文件是否存在
 
 @return PDF格式的NSData
 */
- (NSData *)snapshotPDF;

#pragma mark - 对视图的处理

/**
 删除所有子视图
 */
- (void)removeAllSubviews;

/**
 下面两个方法都会涉及到设置layer的圆角就会涉及到是否光栅化
 当shouldRasterize设成YES时，layer被渲染成一个bitmap，并缓存起来，等下次使用时不会再重新去渲染了。
 实现圆角本身就是在做颜色混合（blending），如果每次页面出来时都blending，消耗太大。
 shouldRasterize = YES，下次就只是简单的从渲染引擎的cache里读取那张bitmap，节约系统资源。
 像滚动tableView时由于cell的复用，cell会多次绘制，每次都执行圆角设置，肯定会阻塞UI，设置这个将会使滑动更加流畅。
 当我们使用得当（视图是静态时），光栅化可以提供很大的性能优势，但是一定要避免用在内容是动态变化的图层上，不然它缓存方面的优势就会丧失，而且会让性能变的更糟。
 设置 shouldRasterize 的同时也要设置 rasterizationScale。
 虽然apple官方开发文件仅仅很保守的提及了透明度效果无法进行Rasterize（光柵化），然而在真机上的执行却会造成图像破碎跟闪烁的结果。
 */

/**
 使用贝塞尔曲线画圆角，若是view使用了此方法画圆角无法再使用view.layer.shadow对此view画阴影
 
 @param rect 贝塞尔曲线的位置与大小
 @param corner view四个角，哪些需要画圆角
 @param radio 圆角半径
 */
- (void)drawCornerWithRect:(CGRect)rect
                    corner:(UIRectCorner)corner
                     radio:(CGFloat)radio;

/**
 对view设置阴影，layerRadius是在有阴影时设置view四个角都为多大的圆角
 
 @param color 阴影的颜色
 @param offset 偏移量，是个CGSize,width与height都可正可负，width正负代表左右偏移，height正负代表上下偏移
 @param opacity 透明度，值0-1
 @param shadowRadius 阴影半径
 @param layerCornerRadius view四个角的圆角半径
 */
- (void)drawShadowWithColor:(UIColor *)color
                     offset:(CGSize)offset
                    opacity:(float)opacity
               shadowRadius:(CGFloat)shadowRadius
          layerCornerRadius:(CGFloat)layerCornerRadius;

/**
 将point由point所在的视图（即调用者）转换到目标视图view中，返回在目标视图view中的point
 
 @param point 待转换的point
 @param view 目标视图
 
 @return 相对于view的point
 */
- (CGPoint)convertPoint:(CGPoint)point toViewOrWindow:(UIView *)view;

/**
 将point从view中转换到调用者视图中，返回在调用者视图中的point

 @param point 待转换的point
 @param view 待转换视图的父视图

 @return 相对于调用视图的point
*/
- (CGPoint)convertPoint:(CGPoint)point fromViewOrWindow:(UIView *)view;

/**
 将rect由rect所在的视图（即调用者）转换到目标视图view中，返回在目标视图view中的rect。

 @param rect 待转换的rect
 @param view 目标视图
 
 @return 相对于view的rect
*/
- (CGRect)convertRect:(CGRect)rect toViewOrWindow:(UIView *)view;

/**
 将rect从view中转换到调用者视图中，返回在调用者视图中的rect

 @param rect 待转换的rect
 @param view 待转换视图的父视图

 @return 相对于调用视图的rect
*/
- (CGRect)convertRect:(CGRect)rect fromViewOrWindow:(UIView *)view;

/**
 对progressHUD添加取消按钮
 
 @param clickedBlock 点击取消按钮的block
 */
- (void)addProgressHUDCancelBtnWithClickedBlock:(void(^)(void))clickedBlock;

#pragma mark - 动画

/**
 淡入
 
 @param duration 持续时间
 @param completion 动画完成block
 */
- (void)fadeinAnimationWithDuration:(NSTimeInterval)duration completion:(nullable void(^)(void))completion;

/**
 淡出
 
 @param duration 持续时间
 @param completion 动画完成block
 */
- (void)fadeoutAnimationWithDuration:(NSTimeInterval)duration completion:(nullable void(^)(void))completion;

/**
 由小变大
 
 @param duration 持续时间
 @param completion 动画完成block
 */
- (void)expandAnimationWithDuration:(NSTimeInterval)duration completion:(nullable void(^)(void))completion;

/**
 由大变小
 
 @param duration 持续时间
 @param completion 动画完成block
 */
- (void)witherAnimationWithDuration:(NSTimeInterval)duration completion:(nullable void(^)(void))completion;

/**
 一直旋转（可顺时针、逆时针）
 
 @param duration 持续时间
 @param clockwise YES 顺时针，NO 逆时针
 */
- (void)rotationAnimationByAlwaysWithDuration:(NSTimeInterval)duration clockwise:(BOOL)clockwise;

/**
 旋转（可顺时针、逆时针）

 @param duration 持续时间
 @param clockwise YES 顺时针，NO 逆时针
 @param completion 动画完成block
*/
- (void)rotationAnimationWithDuration:(NSTimeInterval)duration
                            clockwise:(BOOL)clockwise
                           completion:(nullable void(^)(void))completion;

#pragma mark - 查询view相关对象

/**
 找到它的viewController
 */
@property (nullable, nonatomic, readonly) UIViewController *viewController;

#pragma mark - view的快捷frame相关属性设置

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize  size;

@end

NS_ASSUME_NONNULL_END
