//
//  AppDelegate+AppService.m
//  HKBaseClasses
//
//  Created by hooyking on 2020/5/26.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import "AppDelegate+AppService.h"

@implementation AppDelegate (AppService)

- (void)initAppSetting {
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].toolbarTintColor = [UIColor blackColor];
}

- (void)add3dTouch {
    UIApplicationShortcutIcon *favrite = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd];
    UIApplicationShortcutItem *itemOne = [[UIApplicationShortcutItem alloc] initWithType:@"add" localizedTitle:@"添加" localizedSubtitle:nil icon:favrite userInfo:nil];
    
    UIApplicationShortcutIcon *bookMark = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch];
    UIApplicationShortcutItem *itemTwo = [[UIApplicationShortcutItem alloc] initWithType:@"search" localizedTitle:@"搜索" localizedSubtitle:nil icon:bookMark userInfo:nil];
    
    UIApplicationShortcutIcon *iconContact = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLocation];
    UIApplicationShortcutItem *itemThree = [[UIApplicationShortcutItem alloc] initWithType:@"address" localizedTitle:@"地点" localizedSubtitle:nil icon:iconContact userInfo:nil];
    
    [UIApplication sharedApplication].shortcutItems = @[itemOne, itemTwo, itemThree];
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(nonnull UIApplicationShortcutItem *)shortcutItem completionHandler:(nonnull void (^)(BOOL))completionHandler {
    UITabBarController *tabBarVC = (UITabBarController *)self.window.rootViewController;
    if ([shortcutItem.type isEqualToString:@"add"]) {
        tabBarVC.selectedIndex = 0;
    } else if ([shortcutItem.type isEqualToString:@"search"]) {
        tabBarVC.selectedIndex = 1;
    } else {
        tabBarVC.selectedIndex = 2;
    }
    if (completionHandler) {
        completionHandler(YES);
    }
}

+ (void)setInterfaceOrientation:(UIInterfaceOrientation)orientation {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        UIInterfaceOrientation val = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

@end
