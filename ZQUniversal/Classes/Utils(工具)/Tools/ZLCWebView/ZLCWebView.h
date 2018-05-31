//
//  ZLCWebView.h
//  封装WKWebView和UIWebView
//
//  Created by shining3d on 16/6/17.
//  Copyright © 2016年 shining3d. All rights reserved.
//
/* 优化WebView性能，当系统版本大于8.0时候选择WKWebView降低性能消耗，当小于8.0时候使用UIWebView进行加载 */

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@class ZLCWebView;
@protocol ZLCWebViewDelegate <NSObject>
@optional
- (void)zlcwebView:(ZLCWebView *)webview didFinishLoadingURL:(NSURL *)URL;
- (void)zlcwebView:(ZLCWebView *)webview didFailToLoadURL:(NSURL *)URL error:(NSError *)error;
- (void)zlcwebView:(ZLCWebView *)webview shouldStartLoadWithURL:(NSURL *)URL;
- (void)zlcwebViewDidStartLoad:(ZLCWebView *)webview;
- (BOOL)zlcwebView:(ZLCWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
@end

@interface ZLCWebView : UIView<WKNavigationDelegate, WKUIDelegate, UIWebViewDelegate>









#pragma mark - Public Properties

//zlcdelegate
@property (nonatomic, weak) id <ZLCWebViewDelegate> delegate;

// The main and only UIProgressView
@property (nonatomic, strong) UIProgressView *progressView;
// The web views
// Depending on the version of iOS, one of these will be set
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) UIWebView *uiWebView;



#pragma mark - Initializers view
- (instancetype)initWithFrame:(CGRect)frame;


#pragma mark - Static Initializers
@property (nonatomic, strong) UIBarButtonItem *actionButton;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIColor *barTintColor;
@property (nonatomic, assign) BOOL actionButtonHidden;
@property (nonatomic, assign) BOOL showsURLInNavigationBar;
@property (nonatomic, assign) BOOL showsPageTitleInNavigationBar;

//Allow for custom activities in the browser by populating this optional array
@property (nonatomic, strong) NSArray *customActivityItems;

#pragma mark - Public Interface


// Load a NSURLURLRequest to web view
// Can be called any time after initialization
- (void)loadRequest:(NSURLRequest *)request;

// Load a NSURL to web view
// Can be called any time after initialization
- (void)loadURL:(NSURL *)URL;

// Loads a URL as NSString to web view
// Can be called any time after initialization
- (void)loadURLString:(NSString *)URLString;


// Loads an string containing HTML to web view
// Can be called any time after initialization
- (void)loadHTMLString:(NSString *)HTMLString;

@end
