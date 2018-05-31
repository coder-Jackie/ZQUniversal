//
//  ZQCommonWebVC.m
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/29.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import "ZQCommonWebVC.h"
#import "ZQOcModel.h"

@interface ZQCommonWebVC () <ZLCWebViewDelegate,ZQOcModelDelegate>

/** JS交互上下文 */
@property(nonatomic,strong)JSContext *jsContext;

/** JS交互对象 */
@property (nonatomic, strong) ZQOcModel *model;

/** 返回item */
@property (nonatomic,strong)UIBarButtonItem *customBackBarItem;


@end

@implementation ZQCommonWebVC


#pragma mark- 懒加载区

- (ZLCWebView *)webView
{
    if (!_webView) {
        _webView = [[ZLCWebView alloc]init];
        _webView.delegate = self;
        _webView.uiWebView.allowsInlineMediaPlayback = YES;
        
        if (@available(iOS 11.0, *)) {
            _webView.uiWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        };
        
        [self.view addSubview:_webView];
        [_webView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    return _webView;
    
}


// 自定义返回按钮懒加载
- (UIBarButtonItem *)customBackBarItem {
    
    if (!_customBackBarItem) {
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"btn_back_new"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"btn_back_new"] forState:UIControlStateHighlighted];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        button.bounds = CGRectMake(0, 0, 44, 30);
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        if (@available(iOS 11.0, *)) {
            button.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        };
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(backItemClicked) forControlEvents:UIControlEventTouchUpInside];
        _customBackBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
    }
    return _customBackBarItem;
}


// 直播课非首页返回按钮点击
- (void)backItemClicked
{
//    ZQLog(@"webView.anGoBack:= %zd",self.webView.uiWebView.canGoBack);
    if (self.webView.uiWebView.canGoBack) {
        [self.webView.uiWebView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 自定义导航返回按钮
    self.navigationItem.leftBarButtonItem = self.customBackBarItem;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];

    // 创建交互对象
    ZQOcModel *model  = [[ZQOcModel alloc] init];
    model.delegate = self;
    model.jsContext = self.jsContext;
    model.webView = self.webView.uiWebView;
    self.model = model;
}

#pragma mark- setter方法区

- (void)setLoadUrl:(NSString *)loadUrl
{
    _loadUrl = loadUrl;
    [self.webView loadURL:[NSURL URLWithString:loadUrl]];
}


#pragma mark- ZLCWebViewDelegate

- (void)zlcwebView:(ZLCWebView *)webview shouldStartLoadWithURL:(NSURL *)URL
{
    ZQLog(@"%s",__func__);
    NSLog(@"截取到URLString：%@",URL.absoluteString);
}


- (void)zlcwebViewDidStartLoad:(ZLCWebView *)webview
{
    ZQLog(@"%s",__func__);
    NSLog(@"页面开始加载注入yimiNative");
    self.jsContext =[self.webView.uiWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"yimiNative"] = _model;
    
    NSString *js = @"yimiNative.yimiNativeJoin";
    [self evaluateJS:js];
    
}


- (void)zlcwebView:(ZLCWebView *)webview didFinishLoadingURL:(NSURL *)URL
{
    
    ZQLog(@"%s",__func__);
    // 获取UIWebview的javascript执行环境。
    self.jsContext =[self.webView.uiWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"yimiNative"] = _model;
    NSString *theTitle=[webview.uiWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
    //    self.title = theTitle;
//    self.navBar.navTitle = theTitle;
    self.navigationItem.title = theTitle;
}

- (void)zlcwebView:(ZLCWebView *)webview didFailToLoadURL:(NSURL *)URL error:(NSError *)error
{
    ZQLog(@"加载出现错误error:%@",error);
}

#pragma mark- 封装OC调用JS方法
- (void)evaluateJS:(NSString*)js{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.webView.uiWebView stringByEvaluatingJavaScriptFromString:js];
    });
}

-(void)dealloc {
    ZQLog(@"新的web销毁");
    _webView.uiWebView.delegate = nil;
    _webView.delegate = nil;
}

@end
