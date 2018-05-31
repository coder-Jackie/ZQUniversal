//
//  NSString+Empty.m
//  YiMiApp
//
//  Created by xieyan on 15/10/23.
//  Copyright © 2015年 xieyan. All rights reserved.
//

#import "NSString+Empty.h"

@implementation  NSString (NSString_Empty)
+ (BOOL) isBlank:(NSString*)str{
    if (str == nil || str == NULL) {
        return YES;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    //去除字符串中的空格
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
+ (NSString *)validateStr:(NSString*)str{
    if ([NSString isBlank:str]) {
        return @"";
    }else{
        return str;
    }
}

+ (BOOL)isValidatePasswordLength:(NSString *)str{
    if ([str length] < 6 || [str length] > 18) {
        return NO;
    }
    return YES;
}
@end
