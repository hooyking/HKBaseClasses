//
//  HKTableViewController.m
//  renqin
//
//  Created by hooyking on 2019/7/22.
//  Copyright © 2019年 hooyking. All rights reserved.
//

#import "HKTableViewController.h"

@interface HKTableViewController ()

@end

@implementation HKTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
//    kNotifyAdd(receiveOrientationDidChangeNotify, UIDeviceOrientationDidChangeNotification);
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super init];
    if (self) {
        if (style == UITableViewStylePlain) {
            self.style = @"plain";
        }
    }
    return self;
}

- (NSMutableArray *)dataMArr {
    if (!_dataMArr) {
        _dataMArr = [NSMutableArray array];
    }
    return _dataMArr;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.style.length <= 0 ? UITableViewStyleGrouped : UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegateAndDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 0.0001)];
    return vi;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 0.0001)];
    return vi;
}

//- (void)receiveOrientationDidChangeNotify {
//    //       UIInterfaceOrientationUnknown    0          = UIDeviceOrientationUnknown,
//    //       UIInterfaceOrientationPortrait    1         = UIDeviceOrientationPortrait,
//    //       UIInterfaceOrientationPortraitUpsideDown 2  = UIDeviceOrientationPortraitUpsideDown,
//    //       UIInterfaceOrientationLandscapeLeft    3    = UIDeviceOrientationLandscapeRight,
//    //       UIInterfaceOrientationLandscapeRight   4    = UIDeviceOrientationLandscapeLeft
//    HKLog(@"方向%zd",kAppInterfaceOrientation);
//    if (@available(iOS 11.0, *)) {
//        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
//            if (kAppInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
//                make.left.equalTo(self.view).offset(0);
//                make.right.equalTo(self.view).offset(-self.view.safeAreaInsets.right);
//            } else if (kAppInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
//                make.left.equalTo(self.view).offset(self.view.safeAreaInsets.left);
//                make.right.equalTo(self.view).offset(0);
//            } else {
//                make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
//            }
//        }];
//    }
//}

//- (void)dealloc {
//    kNotifyRemove(UIDeviceOrientationDidChangeNotification);
//}

@end
