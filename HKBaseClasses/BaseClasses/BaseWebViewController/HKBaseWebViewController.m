//
//  HKBaseWebViewController.m
//  renqin
//
//  Created by hooyking on 2019/12/23.
//  Copyright © 2019 hooyking. All rights reserved.
//

#import "HKBaseWebViewController.h"

@interface HKBaseWebViewController ()

@end

@implementation HKBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (ProgressWKWebView *)webView {
    if (_webView == nil) {
        _webView = [[ProgressWKWebView alloc] init];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.delegate = self;
        [_webView setProgressTintColor:kUIColorFromHexString(0x25c884) TrackColor:[UIColor clearColor]];
    }
    return _webView;
}

#pragma mark - 外部接口
- (void)loadRequest:(NSURLRequest *)request {
    [self.webView loadRequest:request];
}

- (void)loadURL:(NSURL *)URL {
    [self.webView loadRequest:[NSURLRequest requestWithURL:URL]];
}

- (void)loadURLString:(NSString *)URLString {
    if(!URLString.length) {
        return;
    }
    [self isNeedGetTicketWithUrlStr:URLString];
}

- (void)loadHTMLString:(NSString *)HTMLString{
    [self loadHTMLString:HTMLString baseURL:nil];
}

- (void)loadHTMLString:(NSString *)HTMLString baseURL:(NSURL *)baseURL{
    [self.webView.wkWebView loadHTMLString:HTMLString baseURL:baseURL];
}

- (void)loadFileURL:(NSURL *)loadFileURL allowingReadAccessToURL:(NSURL *)allowingReadAccessToURL{
    [self.webView.wkWebView loadFileURL:loadFileURL allowingReadAccessToURL:allowingReadAccessToURL];
}

-(void)isNeedGetTicketWithUrlStr:(NSString *)urlStr {
    NSURL *URL = [NSURL URLWithString:urlStr];
    [self.webView loadURL:URL];
}

@end
