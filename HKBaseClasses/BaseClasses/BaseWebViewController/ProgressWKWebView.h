//
//  ProgressWKWebView.h
//  renqin
//
//  Created by hooyking on 2019/12/23.
//  Copyright © 2019 hooyking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ProgressWKWebView;
@protocol ProgressWKDelegate <NSObject>

@optional

- (void)hkwebView:(ProgressWKWebView *)webview didFinishLoadingURL:(NSURL *)URL;
- (void)hkwebView:(ProgressWKWebView *)webview didFailToLoadURL:(NSURL *)URL error:(NSError *)error;
- (void)hkwebView:(ProgressWKWebView *)webview shouldStartLoadWithURL:(NSURL *)URL decisionHandler:(void (^)(BOOL cancelTurn))decisionHandler;
- (void)hkwebViewDidStartLoad:(ProgressWKWebView *)webview;
- (void)hkwebViewChangeTitle:(ProgressWKWebView *)webview;

@end

@interface ProgressWKWebView : UIView

@property (nonatomic, strong) WKWebView *wkWebView;

@property (nonatomic, weak) id <ProgressWKDelegate> delegate;

- (void)loadRequest:(NSURLRequest *)request;
- (void)loadURL:(NSURL *)URL;
- (void)loadURLString:(NSString *)URLString;
- (void)loadHTMLString:(NSString *)HTMLString;
- (void)setProgressTintColor:(UIColor *)tintColor TrackColor:(UIColor *)trackColor;

@end

NS_ASSUME_NONNULL_END
