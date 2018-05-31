//
//  GLThirdPartyLogin.h
//  YiMiApp
//
//  Created by xieyan on 15/9/22.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//
#import <UIKit/UIKit.h>

#import <UMShare/UMShare.h>
//#import <UMSocialCore/UMSocialCore.h>

typedef NS_ENUM(NSInteger, GLLoginSelectType) {
    GLLoginViewSelectTypeWeiXin,
    GLLoginViewSelectTypeQQ,
    GLLoginViewSelectTypeSina
};

@interface GLThirdPartyLogin : NSObject
@property (assign, nonatomic) GLLoginSelectType loginSelectType;
//-(void)qqLoginWithViewController:(UIViewController *)viewController success:(void(^)(NSDictionary* userInfo))success failed:(void(^)(NSString* error))failed;
//-(void)weixinLoginWithViewController:(UIViewController *)viewController success:(void(^)(NSDictionary* userInfo))success failed:(void(^)(NSString* error))failed;
//-(void)sinaLoginWithViewController:(UIViewController *)viewController success:(void(^)(NSDictionary* userInfo))success failed:(void(^)(NSString* error))failed;


-(void)qqLoginWithViewController:(UIViewController *)viewController success:(void(^)(id result))success failed:(void(^)(NSError* error))failed;
-(void)weixinLoginWithViewController:(UIViewController *)viewController success:(void(^)(id result))success failed:(void(^)(NSError* error))failed;
-(void)sinaLoginWithViewController:(UIViewController *)viewController success:(void(^)(id result))success failed:(void(^)(NSError* error))failed;


// 通用方法封装暂时没用到
- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType;

@end

