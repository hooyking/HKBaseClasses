//
//  BaseViewModel.h
//  OrePool
//
//  Created by hooyking on 2021/3/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewModel : NSObject

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataMArr;

@end

NS_ASSUME_NONNULL_END
