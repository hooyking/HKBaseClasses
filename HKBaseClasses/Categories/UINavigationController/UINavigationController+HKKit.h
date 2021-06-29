//
//  UINavigationController+HKKit.h
//  HKBaseClasses
//
//  Created by hooyking on 2020/6/9.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (HKKit)

/**
 根据类名找到这个viewController
 
 @param className 待找类名
 
 @return 返回找到的viewController
 */
- (UIViewController *)findViewController:(NSString *)className;

/**
 根据类名push到这个viewController
 
 @param className 待push到的类名
 @param title 跳转到的viewController的title
 @param animated 动画 YES 有，NO 无
 @param userInfo 给viewController传的值
 */
- (void)pushToViewControllerWithClassName:(NSString *)className
                                    title:(NSString * _Nullable)title
                                 animated:(BOOL)animated
                                 userInfo:(NSDictionary * _Nullable)userInfo;

/**
 pop到指定viewController
 
 @param className 需要返回到的vc的类名
 @param animated 动画 YES 有，NO 无
 
 @return pop之后的持有的控制器
 */
- (NSArray *)popToViewControllerWithClassName:(NSString *)className animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
