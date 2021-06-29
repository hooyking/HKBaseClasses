# HMSegmentedControl使用

## ViewController.m

```
@interface ViewController 

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, strong) NSMutableArray *pageMArr;
@property (nonatomic, strong) NSMutableArray *dataMArr;
@property (nonatomic, assign) NSInteger currentIndex;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSArray *currentArr = self.dataMArr[self.currentIndex];
    if (currentArr.count <= 0) {
        UITableView *tableView = (UITableView *)[self.view viewWithTag:self.currentIndex+200];
        [tableView.mj_header beginRefreshing];
    }
}

- (NSMutableArray *)pageMArr {
    if (!_pageMArr) {
        _pageMArr = [NSMutableArray arrayWithArray:@[@1,@1,@1,@1]];
    }
    return _pageMArr;
}

- (NSMutableArray *)dataMArr {
    if (!_dataMArr) {
        _dataMArr = [NSMutableArray array];
        for (int i = 0; i< 4; i++) {
            [_dataMArr addObject:@[]];
        }
    }
    return _dataMArr;
}

- (UIScrollView *)myScrollView {
    if (!_myScrollView) {
        _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kStatusBarH+kNavConH+44, kScreenW, kScreenH-kNavConH-kStatusBarH-44)];
        _myScrollView.pagingEnabled = YES;
        _myScrollView.bounces = NO;
        _myScrollView.delegate = self;
        _myScrollView.backgroundColor = kUIColorFromHexString(0xffffff);
        _myScrollView.contentSize = CGSizeMake(kScreenW*4, kScreenH-44-kNavConH-kStatusBarH);
        _myScrollView.showsHorizontalScrollIndicator = NO;
        _myScrollView.scrollEnabled = NO;
    }
    return _myScrollView;
}

- (HMSegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, StatusBarH+NavConH, kScreenW, 44)];
        _segmentedControl.sectionTitles = @[@"全部",@"聊天记录",@"图片",@"文件"];
        _segmentedControl.imagePosition = HMSegmentedControlImagePositionLeftOfText;
        _segmentedControl.selectionIndicatorHeight = 2.0f;
        _segmentedControl.selectedSegmentIndex = 0;
        _segmentedControl.backgroundColor = [UIColor whiteColor];
        _segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:14]};
        _segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor redColor]};
        _segmentedControl.selectionIndicatorColor = [UIColor redColor];
        _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        __weak typeof(self) weakSelf = self;
        [_segmentedControl setIndexChangeBlock:^(NSInteger index) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.currentIndex = index;
            NSArray *dataArr = [strongSelf.dataMArr objectAtIndex:index];
            if (dataArr.count <= 0) {
                UITableView *tableView = (UITableView *)[weakSelf.view viewWithTag:index+200];
                [tableView.mj_header beginRefreshing];
            }
            [strongSelf.myScrollView scrollRectToVisible:CGRectMake(kScreenW*index, 0, kScreenW, kScreenH-44-NavConH-StatusBarH) animated:YES];
        }];
    }
    return _segmentedControl;
}

- (void)initUI {
    [self.view addSubview:self.segmentedControl];
    [self.view addSubview:self.myScrollView];
    for (int i = 0; i < 4; i++) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenW * i, 0, kScreenW, kScreenH-44-NavConH-StatusBarH) style:UITableViewStylePlain];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.tag = 200+i;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = UIColorFromRGB(0xececec);
        //在这儿写tableView 注册cell
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            tableView.mj_footer.hidden = YES;
            NSDictionary *currentDic;
            if (self.currentIndex == 0) {//全部
                currentDic = @{@"page":@1};
            } else if (self.currentIndex == 1) {//聊天记录
                currentDic = @{@"page":@1,@"collect_type":@0};
            } else if (self.currentIndex == 2) {//图片
                currentDic = @{@"page":@1,@"collect_type":@1};
            } else if (self.currentIndex == 3) {//文件
                currentDic = @{@"page":@1,@"collect_type":@2};
            }
            [self.pageMArr replaceObjectAtIndex:self.currentIndex withObject:@1];
            //这儿写发起网络请求
        }];
        tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            NSInteger currentPage = [[self.pageMArr objectAtIndex:self.currentIndex] integerValue];
            NSDictionary *currentDic;
            if (self.currentIndex == 0) {//全部
                currentDic = @{@"page":@(currentPage)};
            } else if (self.currentIndex == 1) {//聊天记录
                currentDic = @{@"page":@1,@"collect_type":@0};
            } else if (self.currentIndex == 2) {//图片
                currentDic = @{@"page":@(currentPage),@"collect_type":@1};
            } else if (self.currentIndex == 3) {//文件
                currentDic = @{@"page":@(currentPage),@"collect_type":@2};
            }
            currentPage ++;
            [self.pageMArr replaceObjectAtIndex:self.currentIndex withObject:@(currentPage)];
            //这儿写发起网络请求
        }];
        [self.myScrollView addSubview:tableView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.myScrollView]) {
        NSInteger index = scrollView.contentOffset.x/kScreenW;
        self.currentIndex = index;
        self.segmentedControl.selectedSegmentIndex = index;
        NSArray *dataArr = [self.dataMArr objectAtIndex:index];
        if (dataArr.count <= 0) {
            UITableView *tableView = (UITableView *)[self.view viewWithTag:index+200];
            tableView.mj_footer.hidden = YES;
            [tableView.mj_header beginRefreshing];
        }
    }
}


@end

```