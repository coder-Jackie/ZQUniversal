//
//  ZQNetWorkMessage.m
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/30.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import "ZQNetWorkMessage.h"

@implementation ZQNetWorkMessage

+(void)netfailed{
    [OMGToast showWithText:@"" duration:2];
}

+(void)netfailedTextTip
{
    [OMGToast showWithText:@"网络不给力，请检查网络情况并重试" duration:2];
}

+(void)returnFailed:(NSString*)msg{
    
    if ([NSString isBlank:msg]) {
        msg = @"";
    }
    [OMGToast showWithText:msg duration:2];
}

@end
