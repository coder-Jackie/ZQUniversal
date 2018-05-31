//
//  GLThirdPartyLogin.m
//  YiMiApp
//
//  Created by xieyan on 15/9/22.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "GLThirdPartyLogin.h"
//#import <UMSocial.h>
#import "GLLoginReturnData.h"

@implementation GLThirdPartyLogin

-(void)qqLoginWithViewController:(UIViewController *)viewController success:(void(^)(id result))success failed:(void(^)(NSError *error))failed {
    _loginSelectType                 = GLLoginViewSelectTypeQQ;
    //    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    //
    //    snsPlatform.loginClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
    //
    //        //          获取微博用户名、uid、token等
    //
    //        if (response.responseCode == UMSResponseCodeSuccess) {
    //
    //            [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToQQ  completion:^(UMSocialResponseEntity *response){
    //                NSDictionary * dic = [self createDictionaryWithResponse:response];
    //                success(dic);
    //            }];
    //        } else if (response.responseCode == UMSResponseCodeCancel){
    //            failed(@"用户取消授权");
    //        } else {
    //            failed(response.message);
    //        }
    //    });
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:viewController completion:^(id result, NSError *error) {
        if (error) {
            failed(error);
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"QQ uid: %@", resp.uid);
            NSLog(@"QQ openid: %@", resp.openid);
            NSLog(@"QQ accessToken: %@", resp.accessToken);
            NSLog(@"QQ expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"QQ name: %@", resp.name);
            NSLog(@"QQ iconurl: %@", resp.iconurl);
            NSLog(@"QQ gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"QQ originalResponse: %@", resp.originalResponse);
            
            success(result);
        }
    }];
    
}

-(void)weixinLoginWithViewController:(UIViewController *)viewController success:(void(^)(id result))success failed:(void(^)(NSError* error))failed {
    _loginSelectType = GLLoginViewSelectTypeWeiXin;
    //    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    //
    //    snsPlatform.loginClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
    //
    //        if (response.responseCode == UMSResponseCodeSuccess) {
    //            [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToWechatSession  completion:^(UMSocialResponseEntity *response){
    //                NSDictionary * dic = [self createDictionaryWithResponse:response];
    //                success(dic);
    //            }];
    //        } else if (response.responseCode == UMSResponseCodeCancel){
    //            failed(@"用户取消授权");
    //        } else {
    //            failed(response.message);
    //        }
    //
    //    });
    
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:viewController completion:^(id result, NSError *error) {
        if (error) {
            failed(error);
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
            success(result);
        }
    }];
}


-(void)sinaLoginWithViewController:(UIViewController *)viewController success:(void(^)(id result))success failed:(void(^)(NSError* error))failed {
    _loginSelectType = GLLoginViewSelectTypeSina;
    //    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    //
    //    snsPlatform.loginClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
    //
    //        //          获取微博用户名、uid、token等
    //
    //        if (response.responseCode == UMSResponseCodeSuccess) {
    //            [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
    //                NSDictionary * dic = [self createDictionaryWithResponse:response];
    //                success(dic);
    //            }];
    //
    //        } else {
    //            failed(response.message);
    //        }
    //    });
    
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:viewController completion:^(id result, NSError *error) {
        if (error) {
            failed(error);
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Sina uid: %@", resp.uid);
            NSLog(@"Sina accessToken: %@", resp.accessToken);
            NSLog(@"Sina refreshToken: %@", resp.refreshToken);
            NSLog(@"Sina expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Sina name: %@", resp.name);
            NSLog(@"Sina iconurl: %@", resp.iconurl);
            NSLog(@"Sina gender: %@", resp.unionGender);
            
            // 第三方平台SDK源数据
            NSLog(@"Sina originalResponse: %@", resp.originalResponse);
            
            success(result);
        }
    }];
    
}

//- (NSDictionary *)createDictionaryWithResponse:(UMSocialResponseEntity *)response {
//    NSDictionary * dataDictionary = response.data;
//
//    GLLoginReturnDataSina  *sinaLoginData = [[GLLoginReturnDataSina alloc] init];
//    GLLoginReturnData *loginData = [[GLLoginReturnData alloc] init];
//    if (_loginSelectType == GLLoginViewSelectTypeSina) {
//
//    [sinaLoginData setValuesForKeysWithDictionary:dataDictionary];
//    } else if (_loginSelectType == GLLoginViewSelectTypeQQ || _loginSelectType == GLLoginViewSelectTypeWeiXin) {
//     [loginData setValuesForKeysWithDictionary:dataDictionary];
//    }
//    NSDictionary * userInfoDictionary = [NSDictionary dictionaryWithObjectsAndKeys:sinaLoginData, @"sinaUser", loginData, @"weiChatOrQQUser", nil];
//    return userInfoDictionary;
//}


- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.unionGender);
        
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
    }];
}

@end
