//
//  BaseViewModel.m
//  OrePool
//
//  Created by hooyking on 2021/3/22.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

- (NSMutableArray *)dataMArr {
    if (!_dataMArr) {
        _dataMArr = [NSMutableArray array];
    }
    return _dataMArr;
}

- (NSInteger)page {
    if (!_page) {
        _page = 1;
    }
    return _page;
}

@end
