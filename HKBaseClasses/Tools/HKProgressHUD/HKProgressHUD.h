//
//  HKProgressHUD.h
//  HKBaseClasses
//
//  Created by hooyking on 2020/6/3.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ProgressHUDMode) {
    ProgressHUDModeActivityIndicator = 0,//菊花
    ProgressHUDModeOnlyText = 1,         //只有文字
    ProgressHUDModeProgress = 2,         //带进度条
    ProgressHUDModeCustomView = 3        //自定义view
};

@interface HKProgressHUD : NSObject

/**
 展示多少秒后隐藏的progressHUD

 @param mode progressHUD模式
 @param text 需要展示的文字
 @param delay 多少秒后隐藏
 @param customView 自定义view
 @param canTouchMask 能否点击遮罩层下面的view产生响应 YES 能，NO 不能
 @param view 显示在那个view上
*/
+ (void)showProgressHUDWithMode:(ProgressHUDMode)mode
                       withText:(NSString * _Nullable)text
                     afterDelay:(NSTimeInterval)delay
                     customView:(UIView * _Nullable)customView
                   canTouchMask:(BOOL)canTouchMask
                         inView:(UIView * _Nullable)view;

/**
 展示一直存在的progressHUD，可带取消按钮
 
 @param mode progressHUD模式
 @param text 需要展示的文字
 @param hiddenCancelBtn 取消按钮 YES 隐藏，NO 显示
 @param customView 自定义view
 @param canTouchMask 能否点击遮罩层下面的view产生响应 YES 能，NO 不能
 @param view 显示在那个view上
 @param cancelBlock 点击取消按钮的block
 */
+ (void)showProgressHUDWithMode:(ProgressHUDMode)mode
                       withText:(NSString * _Nullable)text
                hiddenCancelBtn:(BOOL)hiddenCancelBtn
                     customView:(UIView * _Nullable)customView
                   canTouchMask:(BOOL)canTouchMask
                         inView:(UIView * _Nullable)view
                    cancelBlock:(void(^)(void))cancelBlock;

/**
 隐藏progressHUD
 
 @param delay 多少秒后隐藏（值0 ～ +∞）
 */
+ (void)hideProgressHUDAfterDelay:(NSTimeInterval)delay;

/**
 当progressHUD的mode为ProgressHUDModeProgress时设置进度
 
 @param progress 进度(值0 ~ 1)
 */
+ (void)setProgress:(CGFloat)progress;

/**
 设置progressHUD上bezelView主题色
 
 @param contentColor 主题color
 */
+ (void)setContentColor:(UIColor *)contentColor;

@end

NS_ASSUME_NONNULL_END
