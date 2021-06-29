//
//  UIViewController+HKKit.h
//  HKBaseClasses
//
//  Created by hooyking on 2020/5/20.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HKKit)

/**
 此vc通过present跳转vc的最上层vc
 */
@property (nonatomic, readonly, strong) UIViewController *topPresentingViewController;

/**
 此vc通过present跳转vc的最下层vc
*/
@property (nonatomic, readonly, strong) UIViewController *bottomPresentedViewController;

@end

NS_ASSUME_NONNULL_END
