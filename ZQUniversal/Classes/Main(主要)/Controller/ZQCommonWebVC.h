//
//  ZQCommonWebVC.h
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/29.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import "ZQBaseViewController.h"
#import "ZLCWebView.h"

@interface ZQCommonWebVC : ZQBaseViewController

/** webView里面包含WKWebView和UIWebView ios8自动使用WKWebView 现在用的是UIWebView 为了便于前段调用统一 */
@property (nonatomic, strong) ZLCWebView *webView;
/** 需要显示的title */
@property (nonatomic, copy) NSString *titleStr;
/** 需要加载的URL */
@property (nonatomic, copy) NSString *loadUrl;

@end
