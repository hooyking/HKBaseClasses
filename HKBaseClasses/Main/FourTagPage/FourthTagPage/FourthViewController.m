//
//  FourthViewController.m
//  HKBaseClasses
//
//  Created by hooyking on 2020/4/27.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import "FourthViewController.h"


@interface FourthViewController ()

@property (nonatomic, strong) UIView *subView;

@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataMArr = [@[@"iOS13新特性"] mutableCopy];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if (@available(iOS 13.0, *)) {
        if (UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            self.tableView.backgroundColor = [UIColor redColor];
        } else {
            self.tableView.backgroundColor = [UIColor greenColor];
        }
    } else {
        self.tableView.backgroundColor = [UIColor greenColor];
    }
    self.subView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.subView.layer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view addSubview:self.subView];
    [self.view bringSubviewToFront:self.subView];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
// trait发生了改变
    if (@available(iOS 13.0, *)) {
        if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
            // 执行操作
            if (previousTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                HKLog(@"dark");
            } else {
                HKLog(@"light");
            }
        }
    } else {
        // Fallback on earlier versions
    }
    UIColor *dyColor;
    if (@available(iOS 13.0, *)) {
        dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
            if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                return [UIColor blueColor];
            }
            else {
                return [UIColor yellowColor];
            }
        }];
    } else {
        // Fallback on earlier versions
        dyColor = [UIColor blueColor];
    }
    self.subView.layer.backgroundColor = dyColor.CGColor;
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
    NSArray *vcArray = @[@"IOS13NewUsedViewController"];
    [self.navigationController pushToViewControllerWithClassName:vcArray[indexPath.row] title:self.dataMArr[indexPath.row] animated:YES userInfo:nil];
}

@end
