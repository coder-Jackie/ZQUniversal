//
//  GLShareManager.h
//  YiMiApp
//
//  Created by xieyan on 15/9/18.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "UMSocialSnsService.h"
//#import "UMSocialSnsPlatformManager.h"


//#import <UMSocialCore/UMSocialCore.h>
#import <UMShare/UMShare.h>
#import <UShareUI/UShareUI.h>



@interface GLShareManager : NSObject
/**
 *  使用友盟分享界面分享
 *
 *  @param contentDic          分享内容
 *  @param presentedController 当前视图控制器
 */
//- (void)uMengShareWithContent:(NSDictionary *)contentDic presentedController:(UIViewController *)presentedController;


//使用自己界面分享

/**
 *  友盟QQ分享
 *
 *  @param title    title description
 *  @param url      url description
 *  @param image    image description
 *  @param describe describe description
 */
- (void)UMShareToQQWithTitle:(NSString *)title shareUrl:(NSString *)url imageUrl:(NSString *)imageUrl describe:(NSString *)describe presentedController:presentedController;
/**
 *  友盟QQ空间分享
 *
 *  @param title    title description
 *  @param url      url description
 *  @param image    image description
 *  @param describe describe description
 */
- (void)UMShareToQQZoneWithTitle:(NSString *)title shareUrl:(NSString *)url imageUrl:(NSString *)imageUrl describe:(NSString *)describe presentedController:presentedController;

/**
 *  友盟WeiChat好友分享
 *
 *  @param title    title description
 *  @param url      url description
 *  @param image    image description
 *  @param describe describe description
 */
- (void)UMShareToWeiChatSessionWithTitle:(NSString *)title shareUrl:(NSString *)url imageUrl:(NSString *)imageUrl describe:(NSString *)describe presentedController:presentedController;

/**
 *  友盟WeiChat朋友圈分享
 *
 *  @param title    title description
 *  @param url      url description
 *  @param image    image description
 *  @param describe describe description
 */
- (void)UMShareToWeiChatTimelineWithTitle:(NSString *)title shareUrl:(NSString *)url imageUrl:(NSString *)imageUrl describe:(NSString *)describe presentedController:presentedController;

/**
 *  友盟Sina分享
 *
 *  @param title    title description
 *  @param url      url description
 *  @param image    image description
 *  @param describe describe description
 */
- (void)UMShareToSinaWithTitle:(NSString *)title shareUrl:(NSString *)url imageUrl:(NSString *)imageUrl describe:(NSString *)describe presentedController:presentedController;

/**
 *  分享图片到平台(js使用)
 *
 */
- (void)UMShareImageToPlatformType:(UMSocialPlatformType)platformType withUrl:(NSString *)url withImageUrl:(NSString *)imageUrl;


/**
 分享结果block
 @param shareResult success fail 两种
 */
@property (nonatomic, copy) void (^shareResultBlock)(NSString *shareResult);
/**  */
@property (nonatomic, assign) BOOL isHideAlert;

@end
