//
//  ZQNetWorkMessage.h
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/30.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kNoNetMessage @"网络不给力哦"

@interface ZQNetWorkMessage : NSObject

+ (void)netfailed;
+ (void)netfailedTextTip;
+ (void)returnFailed:(NSString*)msg;

@end
