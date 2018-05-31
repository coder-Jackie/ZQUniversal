//
//  GLShareManager.m
//  YiMiApp
//
//  Created by xieyan on 15/9/18.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "GLShareManager.h"
#import "OMGToast.h"

@implementation GLShareManager

// 友盟QQ分享
- (void)UMShareToQQWithTitle:(NSString *)title shareUrl:(NSString *)url imageUrl:(NSString *)imageUrl describe:(NSString *)describe presentedController:presentedController {
    [self shareWebPageToPlatformType:UMSocialPlatformType_QQ withTitle:title shareUrl:url imageUrl:imageUrl describe:describe presentedController:presentedController];
}

// 友盟QQ空间分享
- (void)UMShareToQQZoneWithTitle:(NSString *)title shareUrl:(NSString *)url imageUrl:(NSString *)imageUrl describe:(NSString *)describe presentedController:presentedController {
    [self shareWebPageToPlatformType:UMSocialPlatformType_Qzone withTitle:title shareUrl:url imageUrl:imageUrl describe:describe presentedController:presentedController];
}

// 友盟WeiChat好友分享
- (void)UMShareToWeiChatSessionWithTitle:(NSString *)title shareUrl:(NSString *)url imageUrl:(NSString *)imageUrl describe:(NSString *)describe presentedController:presentedController {
    [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession withTitle:title shareUrl:url imageUrl:imageUrl describe:describe presentedController:presentedController];
}

// 友盟WeiChat朋友圈分享
- (void)UMShareToWeiChatTimelineWithTitle:(NSString *)title shareUrl:(NSString *)url imageUrl:(NSString *)imageUrl describe:(NSString *)describe presentedController:presentedController {
    [self shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine withTitle:title shareUrl:url imageUrl:imageUrl describe:describe presentedController:presentedController];
}

// 友盟Sina分享
- (void)UMShareToSinaWithTitle:(NSString *)title shareUrl:(NSString *)url imageUrl:(NSString *)imageUrl describe:(NSString *)describe presentedController:presentedController {
    [self shareWebPageToPlatformType:UMSocialPlatformType_Sina withTitle:title shareUrl:url imageUrl:imageUrl describe:describe presentedController:presentedController];
}

/* 分享调用总接口 */
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType withTitle:(NSString *)title shareUrl:(NSString *)url imageUrl:(NSString *)imageUrl describe:(NSString *)describe presentedController:presentedController
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    
    //创建网页内容对象 使用固定https 测试新浪微博
//    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
//    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"欢迎使用【友盟+】社会化组件U-Share" descr:@"欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！" thumImage:thumbURL];
//    //设置网页地址
//    shareObject.webpageUrl = @"http://mobile.umeng.com/social";
    
    //创建网页内容对象
    //NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:describe thumImage:imageUrl];
    //设置网页地址
    shareObject.webpageUrl = url;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:presentedController completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
    
    
    

    
    
}

// 分享图片到平台(js使用)
- (void)UMShareImageToPlatformType:(UMSocialPlatformType)platformType withUrl:(NSString *)url withImageUrl:(NSString *)imageUrl
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
//    shareObject.thumbImage = [UIImage imageNamed:@"icon"];
//    [shareObject setShareImage:@"https://mobile.umeng.com/images/pic/home/social/img-1.png"];
    
    //shareObject.thumbImage = [UIImage imageNamed:@"icon"];
    [shareObject setShareImage:imageUrl];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
        [self alertWithError:error];
    }];
    
}


- (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"分享成功!"];
        // 告知js分享结果
        if (self.shareResultBlock) {
            self.shareResultBlock(@"success");
        }
        
    }
    else{
        NSMutableString *str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
            }
        }
        if (error) {
            
            // 原来的显示result
            //            result = [NSString stringWithFormat:@"分享失败!: error code: %d\n%@",(int)error.code, str];
            // 控制台打印方法自己查看错误.
            NSLog(@"分享失败!: error code: %d\n%@",(int)error.code, str);
            
            
            // 这里特殊处理显示错误结果
            if (error.code == 2009) {
                str = [[NSMutableString alloc] initWithString:@"已取消分享"];
                result = [NSString stringWithFormat:@"%@", str];
            } else {
                str = [[NSMutableString alloc] initWithString:@""];
                result = [NSString stringWithFormat:@"分享失败!%@", str];
            }
            //result = [NSString stringWithFormat:@"分享失败! %@", str];
        }
        else{
            result = [NSString stringWithFormat:@"分享失败!"];
        }
        
        // 告知js分享结果
        if (self.shareResultBlock) {
            self.shareResultBlock(@"fail");
        }
        
    }
    
    if(!_isHideAlert) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                        message:result
//                                                       delegate:nil
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles:nil];
//        [alert show];
        
        if (!error) {
            [MBProgressHUD showSuccess:result];
        } else {
            [MBProgressHUD showError:result];
        }

    }

}


//- (void)shareResult:(UMSocialResponseEntity *)response {
//    if (response.responseCode == UMSResponseCodeSuccess) {
//        //            NSLog(@"分享成功！");
//        [OMGToast showWithText:@"分享成功！" duration:2];
//        //得到分享到的平台名
//        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
//        
//        
//        if (self.shareResultBlock) {
//            self.shareResultBlock(@"success");
//        }
//        
//    } else {
//        if (response.error) {
//            NSString * errorStr = [NSString stringWithFormat:@"分享失败。原因:%@", response.error];
//            [OMGToast showWithText:errorStr duration:2];
//        }
//        
//        if (self.shareResultBlock) {
//            self.shareResultBlock(@"fail");
//        }
//        
//    }
//}

@end
