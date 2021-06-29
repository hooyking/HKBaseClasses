//
//  UINavigationController+HKKit.m
//  HKBaseClasses
//
//  Created by hooyking on 2020/6/9.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import "UINavigationController+HKKit.h"

@implementation UINavigationController (HKKit)

- (UIViewController *)findViewController:(NSString *)className {
    for (UIViewController *viewController in self.viewControllers) {
        if ([viewController isKindOfClass:NSClassFromString(className)]) {
            return viewController;
        }
    }
    return nil;
}

- (void)pushToViewControllerWithClassName:(NSString *)className
                                    title:(NSString *)title
                                 animated:(BOOL)animated
                                 userInfo:(NSDictionary *)userInfo {
    
    UIViewController *viewController = [NSClassFromString(className) new];
    viewController.title = title;
    NSArray *vcPropertyArray = [HKCommonTools getPropertiesFromObject:viewController];
    [vcPropertyArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([userInfo.allKeys containsObject:obj]) {
            [viewController setValue:[userInfo objectForKey:obj] forKey:obj];
        }
    }];
    [self pushViewController:viewController animated:animated];
}

- (NSArray *)popToViewControllerWithClassName:(NSString *)className animated:(BOOL)animated {
    if (![self findViewController:className]) {
        return nil;
    }
    return [self popToViewController:[self findViewController:className] animated:animated];
}

@end
