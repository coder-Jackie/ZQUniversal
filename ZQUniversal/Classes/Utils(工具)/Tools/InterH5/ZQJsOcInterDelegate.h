//
//  ZQJsOcInterDelegate.h
//  YiMiApp
//
//  Created by CoderZQ on 2017/3/10.
//  Copyright © 2017年 YiMi. All rights reserved.
//  这里定义和JS交互的协议方法.供JS调用.

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>


@protocol ZQJsOcInterDelegate <JSExport>
//// 打开二维码
//-(void)openQRCode:(NSString*)str;

/** js调用oc 获取用户信息：返回用户信息 */
- (void)getUserInfo;

/** js调用oc 如果token过期可以直接跳转原生登录页登录 */
- (void)loginIn;

/** js调用oc分享 参数依次为:分享标题,分享图片地址,分享链接地址 ,分享正文 课程ID 课程类型 调用js方法  shareState(NSString *result) 成功传success,失败传fail */
- (void)share:(NSString *)shareTitle :(NSString *)shareImageUrl :(NSString *)shareUrl :(NSString *)shareContext :(NSString *)sId :(NSString *)refType :(NSString *)isSave;


/** js调用oc分享 参数依次为:分享标题,分享图片地址,分享链接地址 ,分享正文 课程ID 课程类型 是否显示分享按钮 调用js方法(里面参数全部传字符串,如果字段无,传空字符串 前端注意转换) */
- (void)h5Share:(NSString *)shareTitle :(NSString *)shareImageUrl :(NSString *)shareUrl :(NSString *)shareContext :(NSString *)sId :(NSString *)refType :(NSString *)isShow;


/** js调用获取客户端是否安装微信 */
- (void)getsInstallWeChat;

/** js调用oc分享图片 type  :(NSString *)type :(NSString *)url :(NSString *)imgUrl
  WEIXIN_CIRCLE = "WEIXIN_CIRCLE";
  String WEIXIN = "WEIXIN";
  String QQ = "QQ";
  QZONE = "QZONE";
  SINA = "SINA";
 */
- (void)setShareImageByJs:(NSString *)type :(NSString *)url :(NSString *)imgUrl;


/** js调用oc是否是首页 参数 首页 或者 其他字符串 */
- (void)isHomePage:(NSString *)title;


- (void)setIsFollowTeacher:(NSString *)isFollow :(NSString*)tId;


/**
 根据url处理老师详情导航栏头部变化
 */
-(void)getCurrentWebUrl:(NSString *)url;
/**
 直播支付接口

 @param productId 直播课id或者直播系列课id
 @param payFor 支付对象3直播课 4直播系列课
 @param payFid 直播订单id
 */
- (void)livePay:(NSString *)productId :(NSString *)payFor :(NSString *)payFid :(NSString *)money :(NSString *)userName :(NSString *)phoneNum :(NSString *)code;

    
    
/**
 苹果内购支付

 @param productId 商品id
 @param productName 商品名称
 @param amount 金额
 */
- (void)IAPPay:(NSString *)productId :(NSString *)productName :(NSString *)amount;


/**
 JD白条支付结果
 
 @param payResult @"success" @"fail"
 */
- (void)JDPayResult:(NSString *)payResult;

/**
 目前暂时只有试听填写页面的返回
 */
- (void)h5GoBack;

/**
    存储二维码图片
 */
- (void)saveQrcode:(NSString*)QRCodeUrl;

@end
