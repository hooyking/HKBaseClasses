//
//  HKBaseWebViewController.h
//  renqin
//
//  Created by hooyking on 2019/12/23.
//  Copyright © 2019 hooyking. All rights reserved.
//

#import "BaseViewController.h"
#import "ProgressWKWebView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HKBaseWebViewController : BaseViewController<ProgressWKDelegate>

@property (nonatomic,strong)ProgressWKWebView *webView;

- (void)loadURLString:(NSString *)URLString;
- (void)loadHTMLString:(NSString *)HTMLString;
- (void)loadHTMLString:(NSString *)HTMLString baseURL:(NSURL * _Nullable)baseURL;
- (void)loadFileURL:(NSURL *)loadFileURL allowingReadAccessToURL:(NSURL *)allowingReadAccessToURL;

@end

NS_ASSUME_NONNULL_END
