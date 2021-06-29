//
//  AppDelegate.m
//  HKBaseClasses
//
//  Created by hooyking on 2020/4/26.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import "AppDelegate.h"
#import "HKTabBarController.h"
#import "AppDelegate+AppService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initAppSetting];
    if (@available(iOS 13.0, *)) {
        return YES;
    } else {
        UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        window.backgroundColor = [UIColor whiteColor];
        self.window = window;
        HKTabBarController *tabbarController = [[HKTabBarController alloc] init];
        self.window.rootViewController = tabbarController;
        [self.window makeKeyAndVisible];

        YYFPSLabel *fpsLabel = [YYFPSLabel new];
        [fpsLabel sizeToFit];
        fpsLabel.frame = CGRectMake(20, 100, 50, 20);
        [self.window addSubview:fpsLabel];

        [self add3dTouch];

        UIApplicationShortcutItem *shortcutItem = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
        if (shortcutItem) {
            if ([shortcutItem.type isEqualToString:@"add"]) {
                HKLog(@"点击了第一个");
                UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
                vi.backgroundColor = [UIColor redColor];
                [self.window addSubview:vi];
            } else if ([shortcutItem.type isEqualToString:@"search"]) {
                HKLog(@"点击了第二个");
            } else {
                HKLog(@"点击了第三个");
            }
            return NO;
        }
        
    }
    
    return YES;
}

#pragma mark - UISceneSession lifecycle
- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    if (@available(iOS 13.0, *)) {
        return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
    }
    return nil;
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
