//
//  SceneDelegate+AppService.m
//  HKBaseClasses
//
//  Created by hooyking on 2020/6/9.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import "SceneDelegate+AppService.h"

@implementation SceneDelegate (AppService)

- (void)add3dTouch {
//    if(self.window.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
//        UIApplicationShortcutIcon *favrite = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd];
//        UIApplicationShortcutItem *itemOne = [[UIApplicationShortcutItem alloc] initWithType:@"add" localizedTitle:@"添加" localizedSubtitle:nil icon:favrite userInfo:nil];
//
//        UIApplicationShortcutIcon *bookMark = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch];
//        UIApplicationShortcutItem *itemTwo = [[UIApplicationShortcutItem alloc] initWithType:@"search" localizedTitle:@"搜索" localizedSubtitle:nil icon:bookMark userInfo:nil];
//
//        UIApplicationShortcutIcon *iconContact = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLocation];
//        UIApplicationShortcutItem *itemThree = [[UIApplicationShortcutItem alloc] initWithType:@"address" localizedTitle:@"地点" localizedSubtitle:nil icon:iconContact userInfo:nil];
//
//        [UIApplication sharedApplication].shortcutItems = @[itemOne, itemTwo, itemThree];
//    }
    UIApplicationShortcutIcon *favrite = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd];
    UIApplicationShortcutItem *itemOne = [[UIApplicationShortcutItem alloc] initWithType:@"add" localizedTitle:@"添加" localizedSubtitle:nil icon:favrite userInfo:nil];
    
    UIApplicationShortcutIcon *bookMark = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch];
    UIApplicationShortcutItem *itemTwo = [[UIApplicationShortcutItem alloc] initWithType:@"search" localizedTitle:@"搜索" localizedSubtitle:nil icon:bookMark userInfo:nil];
    
    UIApplicationShortcutIcon *iconContact = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLocation];
    UIApplicationShortcutItem *itemThree = [[UIApplicationShortcutItem alloc] initWithType:@"address" localizedTitle:@"地点" localizedSubtitle:nil icon:iconContact userInfo:nil];
    
    [UIApplication sharedApplication].shortcutItems = @[itemOne, itemTwo, itemThree];
}

- (void)windowScene:(UIWindowScene *)windowScene performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler  API_AVAILABLE(ios(13.0)) {
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

@end
