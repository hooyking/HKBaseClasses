//
//  ProgressWKWebView.m
//  renqin
//
//  Created by hooyking on 2019/12/23.
//  Copyright © 2019 hooyking. All rights reserved.
//

#import "ProgressWKWebView.h"

static void *HKWebBrowserContext = &HKWebBrowserContext;

@interface ProgressWKWebView ()<WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation ProgressWKWebView
- (instancetype) initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self createContentView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createContentView];
    }
    return self;
}


- (void)dealloc {
    [self.wkWebView setNavigationDelegate:nil];
    [self.wkWebView setUIDelegate:nil];
    [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(title))];

}

#pragma mark - 控件数据初始化
-(WKWebView *)wkWebView {
    if (!_wkWebView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        WKPreferences *preference = [[WKPreferences alloc]init];
        preference.minimumFontSize = 16;
        config.preferences = preference;

        _wkWebView = [[WKWebView alloc] initWithFrame:self.bounds configuration:config];;
        [_wkWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        [_wkWebView setNavigationDelegate:self];
        [_wkWebView setUIDelegate:self];
        [_wkWebView setMultipleTouchEnabled:YES];
        [_wkWebView setAutoresizesSubviews:YES];
        [_wkWebView.scrollView setAlwaysBounceVertical:YES];
        _wkWebView.scrollView.bounces = YES;
        [_wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:HKWebBrowserContext];
        [_wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(title)) options:NSKeyValueObservingOptionNew context:NULL];

    }
    return _wkWebView;
}

-(UIProgressView *)progressView {
    if (_progressView == nil) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.backgroundColor = [UIColor clearColor];
        [_progressView setTrackTintColor:[UIColor greenColor]];
        [_progressView setTintColor:[UIColor redColor]];
    }
    return _progressView;
}

-(void)createContentView {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.wkWebView];
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.wkWebView.superview);
    }];
    
    [self addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.progressView.superview);
        make.height.equalTo(@(2.0f));
        make.top.equalTo(self.progressView.superview).offset(0);
    }];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    if([self.delegate respondsToSelector:@selector(hkwebViewDidStartLoad:)])
    {
        [self.delegate hkwebViewDidStartLoad:self];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    if([self.delegate respondsToSelector:@selector(hkwebView:didFinishLoadingURL:)])
    {
        [self.delegate hkwebView:self didFinishLoadingURL:self.wkWebView.URL];
    }
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
    if([self.delegate respondsToSelector:@selector(hkwebView:didFailToLoadURL:error:)])
    {
        [self.delegate hkwebView:self didFailToLoadURL:self.wkWebView.URL error:error];
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
    if([self.delegate respondsToSelector:@selector(hkwebView:didFailToLoadURL:error:)])
    {
        [self.delegate hkwebView:self didFailToLoadURL:self.wkWebView.URL error:error];
    }
}

- (void)webView:(WKWebView *)webView
decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction
decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    if([self.delegate respondsToSelector:@selector(hkwebView:shouldStartLoadWithURL:decisionHandler:)])
    {
        [self.delegate hkwebView:self shouldStartLoadWithURL:navigationAction.request.URL decisionHandler:^(BOOL cancelTurn) {
            decisionHandler(cancelTurn?WKNavigationActionPolicyCancel:WKNavigationActionPolicyAllow);
        }];
    }
    else
    {
        NSURL *URL = navigationAction.request.URL;
        if(!navigationAction.targetFrame)
        {
            [self loadURL:URL];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

#pragma mark - WKUIDelegate
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    
}


#pragma mark - Estimated Progress KVO (WKWebView)

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView)
    {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
        __weak typeof(self) weakSelf = self;
        if(self.wkWebView.estimatedProgress >= 1.0f)
        {
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf.progressView setAlpha:0.0f];
            }
                             completion:^(BOOL finished)
            {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else if ([keyPath isEqualToString:NSStringFromSelector(@selector(title))] && object == self.wkWebView)
    {
        if ([self.delegate respondsToSelector:@selector(hkwebViewChangeTitle:)]) {
            [self.delegate hkwebViewChangeTitle:self];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - 外部接口
- (void)loadRequest:(NSURLRequest *)request {
    [self.wkWebView loadRequest:request];
}

- (void)loadURL:(NSURL *)URL {
    [self loadRequest:[NSURLRequest requestWithURL:URL]];
}

- (void)loadURLString:(NSString *)URLString {
    NSURL *URL = [NSURL URLWithString:URLString];
    [self loadURL:URL];
}

- (void)loadHTMLString:(NSString *)HTMLString {
    [self.wkWebView loadHTMLString:HTMLString baseURL:nil];
}

- (void)setProgressTintColor:(UIColor *)tintColor TrackColor:(UIColor *)trackColor {
    [self.progressView setTrackTintColor:trackColor];
    [self.progressView setTintColor:tintColor];
}

@end
