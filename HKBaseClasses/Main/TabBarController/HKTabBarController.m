//
//  HKTabBarController.m
//  HKBaseClasses
//
//  Created by hooyking on 2020/4/27.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import "HKTabBarController.h"
#import "HKBaseNavigationController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

#define kBlackColor    [UIColor blackColor]
#define kRedColor      kUIColorFromHexString(0xd81e06)

@interface HKTabBarController ()

@property (nonatomic, strong) NSArray *allVCArr;

@end

@implementation HKTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *titleArr = @[@"第一项",@"第二项",@"第三项",@"第四项"];
    NSArray *unselectedImageArr = @[@"firstUnselected",@"secondUnselected",@"thirdUnselected",@"fourthUnselected"];
    NSArray *selectedImageArr = @[@"firstSelected",@"secondSelected",@"thirdSelected",@"fourthSelected"];
    NSMutableArray *allNavVC = [NSMutableArray arrayWithCapacity:titleArr.count];
    FirstViewController *firstVC = [[FirstViewController alloc] init];
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    ThirdViewController *thirdVC = [[ThirdViewController alloc] init];
    FourthViewController *fourthVC = [[FourthViewController alloc] init];
    self.allVCArr = @[firstVC,secondVC,thirdVC,fourthVC];
    
    [self.allVCArr enumerateObjectsUsingBlock:^(UIViewController*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HKBaseNavigationController *nv = [[HKBaseNavigationController alloc]initWithRootViewController:obj];
        obj.title = titleArr[idx];
        nv.tabBarItem.image = [[UIImage imageNamed:unselectedImageArr[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nv.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageArr[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [nv.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:kBlackColor,NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateNormal];
        [nv.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:kRedColor,NSFontAttributeName:[UIFont systemFontOfSize:13]} forState:UIControlStateSelected];
        nv.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kBlackColor,NSFontAttributeName:[UIFont systemFontOfSize:17]};
        nv.navigationBar.barTintColor = kRedColor;
        nv.navigationBar.translucent = NO;
        [allNavVC addObject:nv];
    }];
    
    if (@available(iOS 10.0, *)) {
        self.tabBar.unselectedItemTintColor = kBlackColor;
        self.tabBar.tintColor = kRedColor;
    }
    self.viewControllers = allNavVC;
    self.tabBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (BOOL)shouldAutorotate {
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.selectedViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return self.selectedViewController.preferredInterfaceOrientationForPresentation;
}

- (BOOL)prefersStatusBarHidden {
    return self.selectedViewController.prefersStatusBarHidden;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.selectedViewController.preferredStatusBarStyle;
}

@end
