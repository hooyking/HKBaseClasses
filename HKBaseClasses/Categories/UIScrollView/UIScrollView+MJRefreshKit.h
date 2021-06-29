//
//  UIScrollView+MJRefreshKit.h
//  OrePool
//
//  Created by hooyking on 2021/5/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (MJRefreshKit)

- (void)addHeaderRefreshWithAnimation:(BOOL)animation
                         refreshBlock:(void(^)(void))refreshBlock;

- (void)addFooterRefreshWithAutomaticallyRefresh:(BOOL)automaticallyRefresh
                                    refreshBlock:(void(^)(void))refreshBlock;

- (void)setFooterNoData;

@end

NS_ASSUME_NONNULL_END
