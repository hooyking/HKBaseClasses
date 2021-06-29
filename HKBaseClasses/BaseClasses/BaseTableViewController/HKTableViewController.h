//
//  HKTableViewController.h
//  renqin
//
//  Created by hooyking on 2019/7/22.
//  Copyright © 2019年 hooyking. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const cellIdentifier = @"HKBaseTableViewCell";

@interface HKTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSString *style;
@property (nonatomic, strong) NSMutableArray *dataMArr;

- (instancetype)initWithStyle:(UITableViewStyle)style;

@end

NS_ASSUME_NONNULL_END
