//
//  ScreenshotServiceViewController.m
//  HKBaseClasses
//
//  Created by hooyking on 2020/6/11.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import "ScreenshotServiceViewController.h"

@interface ScreenshotServiceViewController ()<UIScreenshotServiceDelegate>

@end

@implementation ScreenshotServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //截屏可选整页，且生成的是pdf文件
    //设置UIScreenshotService代理
    if (@available(iOS 13.0, *)) {
        UIScreenshotService *screenshotService = [UIApplication sharedApplication].keyWindow.windowScene.screenshotService;
        screenshotService.delegate = self;
    }
}

#pragma mark - UITableViewDelegateAndDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = kNSStringFormat(@"第%zd个",indexPath.row);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kAutoH(44);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIScreenshotServiceDelegate
- (void)screenshotService:(UIScreenshotService *)screenshotService generatePDFRepresentationWithCompletion:(void (^)(NSData * _Nullable, NSInteger, CGRect))completionHandler  API_AVAILABLE(ios(13.0)){
    
    //临时更改tableView的尺寸，保证tableView全部内容都能够完整的渲染出来
    CGRect frame = self.tableView.frame;
    CGRect toframe = frame;
    toframe.size = CGSizeMake(self.tableView.frame.size.width, kAutoH(44)*100);
    //这儿根据自身视图用的layout还是frame改变自身尺寸
//    self.tableView.frame = toframe;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(toframe.size.height);
        make.width.mas_equalTo(kScreenW);
        make.top.left.equalTo(self.view);
    }];
    
    //将tableView渲染成PDF，参考：https://stackoverflow.com/questions/5443166/how-to-convert-uiview-to-pdf-within-ios/6566696#6566696
    NSMutableData *pdfData = [NSMutableData data];
    UIGraphicsBeginPDFContextToData(pdfData, toframe, nil);
    UIGraphicsBeginPDFPage();
    CGContextRef pdfContext = UIGraphicsGetCurrentContext();
    
    [self.tableView.layer renderInContext:pdfContext];

    UIGraphicsEndPDFContext();
    
    //恢复tableView本身尺寸
    //这儿根据自身视图用的layout还是frame改变自身尺寸
//    self.tableView.frame = frame;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(frame.size.height);
        make.width.mas_equalTo(kScreenW);
        make.top.left.equalTo(self.view);
    }];

    //返回PDF数据
    completionHandler ? completionHandler(pdfData, 1, self.tableView.bounds) : nil;
}

@end
