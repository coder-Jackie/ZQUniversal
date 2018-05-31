//
//  ZQOcModel.m
//  YiMiApp
//
//  Created by CoderZQ on 2017/3/10.
//  Copyright © 2017年 YiMi. All rights reserved.
//

#import "ZQOcModel.h"

@implementation ZQOcModel

// 获取用户信息
- (void)getUserInfo
{
    ZQLog(@"JS调用getUserInfo");
    if ([self.delegate respondsToSelector:@selector(ZQOcModel:getUserInfo:)]) {
        [self.delegate ZQOcModel:self getUserInfo:nil];
    }
    
}

// 如果token过期可以直接跳转原生登录页登录
- (void)loginIn
{
    ZQLog(@"JS调用loginIn");
    if ([self.delegate respondsToSelector:@selector(ZQOcModel:loginIn:)]) {
        [self.delegate ZQOcModel:self loginIn:nil];
    }
    
}

// js调用获取客户端是否安装微信 */
- (void)getsInstallWeChat
{
    ZQLog(@"JS调用getsInstallWeChat");
    if ([self.delegate respondsToSelector:@selector(ZQOcModel:getsInstallWeChat:)]) {
        [self.delegate ZQOcModel:self getsInstallWeChat:nil];
    }
}


// js调用oc 分享
- (void)share:(NSString *)shareTitle :(NSString *)shareImageUrl :(NSString *)shareUrl :(NSString *)shareContext :(NSString *)sId :(NSString *)refType :(NSString *)isSave
{
    ZQLog(@"JS调用share shareTitle:%@,shareImageUrl:%@,shareUrl:%@,shareContext:%@,sId:%@,refType:%@,isSave:%@",shareTitle,shareImageUrl,shareUrl,shareContext,sId,refType,isSave);
    if ([self.delegate respondsToSelector:@selector(ZQOcModel:share:::::::)]) {
        [self.delegate ZQOcModel:self share:shareTitle :shareImageUrl :shareUrl :shareContext :sId :refType :isSave];
    }
    
}

// js调用oc 分享 给前端 提供导航栏 右上角是否显示分享按钮 的功能
- (void)h5Share:(NSString *)shareTitle :(NSString *)shareImageUrl :(NSString *)shareUrl :(NSString *)shareContext :(NSString *)sId :(NSString *)refType :(NSString *)isShow
{
    ZQLog(@"JS调用h5Share shareTitle:%@,shareImageUrl:%@,shareUrl:%@,shareContext:%@,sId:%@,refType:%@,isSave:%@",shareTitle,shareImageUrl,shareUrl,shareContext,sId,refType,isShow);
    if ([self.delegate respondsToSelector:@selector(ZQOcModel:h5Share:::::::)]) {
        [self.delegate ZQOcModel:self h5Share:shareTitle :shareImageUrl :shareUrl :shareContext :sId :refType :isShow];
    }
}


// js调用oc 分享图片
- (void)setShareImageByJs:(NSString *)type :(NSString *)url :(NSString *)imgUrl;
{
    ZQLog(@"JS调用setShareImageByJs type:%@,url:%@,imgUrl:%@",type,url,imgUrl);
    if ([self.delegate respondsToSelector:@selector(ZQOcModel:setShareImageByJs:::)]) {
        [self.delegate ZQOcModel:self setShareImageByJs:type :url :imgUrl];
    }
    
}

//- (void)ZQOcModel:(ZQOcModel *)ocModel setShareImageByJs:(NSString *)type :(NSString *)url :(NSString *)imgUrl
//{
//    NSLog(@"JS调用setShareImageByJs type:%@,url:%@,imgUrl:%@",type,url,imgUrl);
////    if ([self.delegate respondsToSelector:@selector(ZQOcModel:setShareImageByJs:::)]) {
////        [self.delegate ZQOcModel:self setShareImageByJs:type :url :imgUrl];
////    }
//    
//    if ([self.delegate respondsToSelector:@selector(ZQOcModel:setShareImageByJs:::)]) {
//        [self.delegate ZQOcModel:self setShareImageByJs:type :url :imgUrl];
//    }
//    
//}


// 是否是首页 参数 统一 传字符串
- (void)isHomePage:(NSString *)title
{
    ZQLog(@"JS调用isHomePage:title:%@",title);
    if ([self.delegate respondsToSelector:@selector(ZQOcModel:isHomePage:)]) {
        [self.delegate ZQOcModel:self isHomePage:title];
    }

}

// 直播交互支付方法
- (void)livePay:(NSString *)productId :(NSString *)payFor :(NSString *)payFid :(NSString *)money :(NSString *)userName :(NSString *)phoneNum :(NSString *)code
{
    
    ZQLog(@"JS调用livePay productId:%@,payFor:%@,payFid:%@,money:%@,userName:%@,phoneNum:%@",productId,payFor,payFid,money,userName,phoneNum);
    if ([self.delegate respondsToSelector:@selector(ZQOcModel:livePay:::::::)]) {
        [self.delegate ZQOcModel:self livePay:productId :payFor :payFid :money :userName :phoneNum :code];
    }
}

// 内购交互支付方法
- (void)IAPPay:(NSString *)productId :(NSString *)productName :(NSString *)amount
{
    ZQLog(@"JS调用IAPPay productId:%@,productName:%@,amount:%@",productId,productName,amount);
    if ([self.delegate respondsToSelector:@selector(ZQOcModel:IAPPay:::)]) {
        [self.delegate ZQOcModel:self IAPPay:productId :productName :amount];
    }
}
    

/**
 老师收藏交互方法

 @param isFollow 是否收藏
 @param tId 老师id
 */
- (void)setIsFollowTeacher:(NSString *)isFollow :(NSString *)tId
{
    ZQLog(@"JS调用setIsFollowTeacher");
    if ([self.delegate respondsToSelector:@selector(ZQOcModel:setIsFollowTeacher::)]) {
        [self.delegate ZQOcModel:self setIsFollowTeacher:isFollow :tId];
    }
}

/**
 根据url处理老师详情导航栏头部变化
 */
-(void)getCurrentWebUrl:(NSString *)url {
    
    ZQLog(@"JS调用getCurrentWebUrl-----%@",self.delegate);
    if ([self.delegate respondsToSelector:@selector(ZQOcModel:getCurrentWebUrl:)]) {
        [self.delegate ZQOcModel:self getCurrentWebUrl:url];
    }
}

//  JD白条支付结果
- (void)JDPayResult:(NSString *)payResult
{
    if ([self.delegate respondsToSelector:@selector(ZQOcModel:JDPayResult:)]) {
        [self.delegate ZQOcModel:self JDPayResult:payResult];
    }
}

-(void)h5GoBack {
    ZQLog(@"JS调用h5GoBack-----%@",self.delegate);
    if ([self.delegate respondsToSelector:@selector(ZQOcModel:h5GoBack:)]) {
        [self.delegate ZQOcModel:self h5GoBack:nil];
    }
}

-(void)saveQrcode:(NSString*)QRCodeUrl {
    ZQLog(@"JS调用--------%s",__func__);
    if ([self.delegate respondsToSelector:@selector(ZQOcModel:saveQrcode:)]) {
        [self.delegate ZQOcModel:self saveQrcode:QRCodeUrl];
    }
}

//// 打开二维码
//-(void)openQRCode:(NSString*)str
//{
//    NSLog(@"获取点击事件%@",str);
//
////    if (self.openQRCodeBlock) {
////        self.openQRCodeBlock();
////    }
//
//    if ([self.delegate respondsToSelector:@selector(ZQOcModel:QRCodeEvent:)]) {
//        [self.delegate ZQOcModel:self QRCodeEvent:str];
//    }
//}

@end
