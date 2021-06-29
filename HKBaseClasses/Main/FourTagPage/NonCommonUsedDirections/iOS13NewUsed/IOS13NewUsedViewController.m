//
//  IOS13NewUsedViewController.m
//  HKBaseClasses
//
//  Created by hooyking on 2020/6/11.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import "IOS13NewUsedViewController.h"

@interface IOS13NewUsedViewController ()

@end

@implementation IOS13NewUsedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.dataMArr = [@[@"ScreenshotServiceViewController",@"",@""] mutableCopy];
    if (@available(iOS 13.0, *)) {
        UIColor *color = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return [UIColor redColor];
            } else {
                return [UIColor greenColor];
            }
        }];
        self.tableView.backgroundColor = color;
    } else {
        self.tableView.backgroundColor = [UIColor redColor];
    }
}

#pragma mark - UITableViewDelegateAndDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataMArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.dataMArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAutoH(44);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *titleArray = @[@"截屏类似UIScrollView可选整页",@"",@""];
    if (@available(iOS 13.0, *)) {
        [self.navigationController pushToViewControllerWithClassName:self.dataMArr[indexPath.row] title:titleArray[indexPath.row] animated:YES userInfo:nil];
    } else {
        [HKAlertTools showAlertViewWithTitle:@"提示" message:@"只有iOS13以上才有以下功能" certainBtnTitle:@"知道了" cancelBtnTitle:nil finishBlock:nil];
    }
}

@end
