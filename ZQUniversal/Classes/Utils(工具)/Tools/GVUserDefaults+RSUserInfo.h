//
//  GVUserDefaults+RSUserInfo.h
//  YiMiApp
//
//  Created by xieyan on 16/4/5.
//  Copyright © 2016年 xieyan. All rights reserved.
//

#import "GVUserDefaults.h"

static NSString *loginStateChangeKey = @"loginchange";

#define kUserInfo [GVUserDefaults standardUserDefaults]

@interface GVUserDefaults (RSUserInfo)

/** 用户ID */
@property (nonatomic, assign) NSInteger user_id;
/** 用户名称 */
@property (nonatomic, weak) NSString *userName;
/** 用户真实姓名 */
@property (nonatomic, weak) NSString *realName;
/** 用户昵称 */
@property (nonatomic, weak) NSString *nickName;
/** 密码 */
@property (nonatomic, weak) NSString *password;
/** 手机号 */
@property (nonatomic, weak) NSString *mobileNo;
/** 头像图片地址 netState*/
@property (nonatomic, weak) NSString *headPicture;
/** 记录网络状态 */
@property (nonatomic, weak) NSString *netState;


/** 是否登录 */
@property (nonatomic, assign) BOOL isLogin;


/** 获取当前设备模型 */
- (NSString *)platform;

@end
