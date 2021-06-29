//
//  UIViewController+HKKit.m
//  HKBaseClasses
//
//  Created by hooyking on 2020/5/20.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import "UIViewController+HKKit.h"
#import <objc/runtime.h>

@implementation UIViewController (HKKit)

//这两个方法是便于随时知道目前处于哪个viewController，只用在AppDelegate中导入此文件就行

//+ (void)load {
//    #ifdef DEBUG
//    Method viewDidAppear = class_getInstanceMethod(self, @selector(viewDidAppear:));
//    Method logViewDidAppear = class_getInstanceMethod(self, @selector(logViewDidAppear:));
//    method_exchangeImplementations(viewDidAppear, logViewDidAppear);
//    #endif
//}
//
//- (void)logViewDidAppear:(BOOL)animated {
//    NSString *className = NSStringFromClass([self class]);
//    if ([className hasPrefix:@"UI"] == NO) {
//        HKLog(@"%@ did appear",className);
//    }
//    [self logViewDidAppear:animated];
//}

- (UIViewController *)topPresentingViewController {
    UIViewController *viewController = self;
    while (viewController.presentingViewController) {
        viewController = viewController.presentingViewController;
    }
    return [viewController isEqual:self] ? nil : viewController;
}

- (UIViewController *)bottomPresentedViewController {
    UIViewController *viewController = self;
    while (viewController.presentedViewController) {
        viewController = viewController.presentedViewController;
    }
    return [viewController isEqual:self] ? nil : viewController;
}

@end
