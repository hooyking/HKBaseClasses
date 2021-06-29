//
//  UIScrollView+MJRefreshKit.m
//  OrePool
//
//  Created by hooyking on 2021/5/17.
//

#import "UIScrollView+MJRefreshKit.h"

@implementation UIScrollView (MJRefreshKit)

- (void)addHeaderRefreshWithAnimation:(BOOL)animation refreshBlock:(void (^)(void))refreshBlock {
//    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
//        refreshBlock ? refreshBlock() : nil;
//    }];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        refreshBlock ? refreshBlock() : nil;
    }];
//    NSMutableArray *images = [NSMutableArray array];
//    for (int i = 1; i<=5; i++) {
//      UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loadgif%d", i]];
//      [images addObject:image];
//    }
//    [header setImages:images forState:MJRefreshStateIdle];
//    [header setImages:images forState:MJRefreshStatePulling];
//    [header setImages:images forState:MJRefreshStateRefreshing];
//
//    header.stateLabel.hidden = NO;
//    header.lastUpdatedTimeLabel.hidden = NO;
    self.mj_header = header;
    
    if (animation) {
        [self.mj_header beginRefreshing];
    } else if (!animation) {
        [self.mj_header executeRefreshingCallback];
    }
}

- (void)addFooterRefreshWithAutomaticallyRefresh:(BOOL)automaticallyRefresh refreshBlock:(void (^)(void))refreshBlock {
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        refreshBlock ? refreshBlock() : nil;
    }];
//    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
//        refreshBlock ? refreshBlock() : nil;
//    }];
//    NSMutableArray *images = [NSMutableArray array];
//    for (int i = 1; i<=5; i++) {
//      UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loadgif%d", i]];
//      [images addObject:image];
//    }
//    [footer setImages:images forState:MJRefreshStateIdle];
//    [footer setImages:images forState:MJRefreshStatePulling];
//    [footer setImages:images forState:MJRefreshStateRefreshing];
//    footer.automaticallyRefresh = automaticallyRefresh;
//    footer.stateLabel.hidden = YES;
    
    self.mj_footer = footer;
}

- (void)setFooterNoData {
    [self.mj_footer endRefreshingWithNoMoreData];
    ((MJRefreshAutoNormalFooter *)self.mj_footer).stateLabel.font = kFontRegular(10);
    ((MJRefreshAutoNormalFooter *)self.mj_footer).stateLabel.textColor = [UIColor lightGrayColor];
}

@end
