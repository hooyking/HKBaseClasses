//
//  AppDelegate+AppService.h
//  HKBaseClasses
//
//  Created by hooyking on 2020/5/26.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (AppService)

/**
 app基本设置
 */
- (void)initAppSetting;
/**
 添加桌面上长按app时跳出的选项
 */
- (void)add3dTouch;

/**
 设置屏幕方向
 */
+ (void)setInterfaceOrientation:(UIInterfaceOrientation)orientation;

@end

NS_ASSUME_NONNULL_END
