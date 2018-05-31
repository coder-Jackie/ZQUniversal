//
//  ZQOcModel.h
//  YiMiApp
//
//  Created by CoderZQ on 2017/3/10.
//  Copyright © 2017年 YiMi. All rights reserved.
//

/*
 调用例子
 引用本类,然后在需要使用的控制器中声明
 @property(nonatomic, strong) JSContext* jsContext;
 @property(nonatomic, strong) UIWebView*webView;
 然后在webViewDidFinishLoad方法中.
 
 ZQOcModel *model  = [[ZQOcModel alloc] init];
 model.delegate = self;
 
 // 获取UIWebview的javascript执行环境。
 self.jsContext =[self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
 self.jsContext[@"APP"] = model;  // APP名字一样.
 model.jsContext = self.jsContext;
 model.webView = self.webView;
 
 
 self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
 context.exception = exceptionValue;
 NSLog(@"异常信息：%@", exceptionValue);
 };
 
 然后准守ZQOcModelDelegate 在控制器中实现协议方法.即可实现交互.(注意线程问题.)

 */

#import <Foundation/Foundation.h>
#import "ZQJsOcInterDelegate.h"
@class ZQOcModel;

@protocol ZQOcModelDelegate <NSObject>
// 代理方法声明
@optional
/** 获取用户信息代理方法 */
- (void)ZQOcModel:(ZQOcModel *)ocModel getUserInfo:(NSString *)str;

/** 如果token过期可以直接跳转原生登录页登录代理方法 */
- (void)ZQOcModel:(ZQOcModel *)ocModel loginIn:(NSString *)str;

/** js调用oc 分享  方法名不能变 */
- (void)ZQOcModel:(ZQOcModel *)ocModel share:(NSString *)shareTitle :(NSString *)shareImageUrl :(NSString *)shareUrl :(NSString *)shareContext :(NSString *)sId :(NSString *)refType :(NSString *)isSave;

/** js调用oc 分享  */
- (void)ZQOcModel:(ZQOcModel *)ocModel h5Share:(NSString *)shareTitle :(NSString *)shareImageUrl :(NSString *)shareUrl :(NSString *)shareContext :(NSString *)sId :(NSString *)refType :(NSString *)isShow;


/** js调用获取客户端是否安装微信 */
- (void)ZQOcModel:(ZQOcModel *)ocModel getsInstallWeChat:(NSString *)str;


/** js调用oc分享图片 不弹出原生窗口 */
- (void)ZQOcModel:(ZQOcModel *)ocModel setShareImageByJs:(NSString *)type :(NSString *)url :(NSString *)imgUrl;

/** js调用oc是否是首页 参数 统一 传字符串 参数title 首页 或者 其他字符串 */
- (void)ZQOcModel:(ZQOcModel *)ocModel isHomePage:(NSString *)title;


- (void)ZQOcModel:(ZQOcModel *)model setIsFollowTeacher:(NSString *)isFollow :(NSString *)tId;

/** 直播支付接口 */
- (void)ZQOcModel:(ZQOcModel *)ocModel livePay:(NSString *)productId :(NSString *)payFor :(NSString *)payFid :(NSString *)money :(NSString *)userName :(NSString *)phoneNum :(NSString *)code;

/** 苹果内购支付 */
- (void)ZQOcModel:(ZQOcModel *)ocModel IAPPay:(NSString *)productId :(NSString *)productName :(NSString *)amount;
    
/** JD白条支付结果 */
- (void)ZQOcModel:(ZQOcModel *)ocModel JDPayResult:(NSString *)payResult;

/**
 根据url处理老师详情导航栏头部变化
 */
- (void)ZQOcModel:(ZQOcModel *)ocModel getCurrentWebUrl:(NSString *)url;


/**
 目前暂时只有试听填写页面的返回
 */
- (void)ZQOcModel:(ZQOcModel *)ocModel h5GoBack:(NSString*)str;

/**
 存储二维码图片
 */
- (void)ZQOcModel:(ZQOcModel *)ocModel saveQrcode:(NSString*)QRCodeUrl;

@end


@interface ZQOcModel : NSObject <ZQJsOcInterDelegate>
/** context对象 */
@property (nonatomic, weak) JSContext *jsContext;
/** webView */
@property (nonatomic, weak) UIWebView *webView;
/** vc */
@property (nonatomic, weak) UIViewController *vc;

/** 代理对象 */
@property (nonatomic, weak) id<ZQOcModelDelegate>delegate;

///** 二维码扫一扫block */
//@property (nonatomic, copy) void(^openQRCodeBlock)();

@end
