//
//  NSString+Empty.h
//  YiMiApp
//
//  Created by xieyan on 15/10/23.
//  Copyright © 2015年 xieyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSString_Empty)
+(BOOL) isBlank:(NSString*)str;
+(NSString *)validateStr:(NSString*)str;

/**
 判断密码的长度6-18位

 @param str <#str description#>
 @return <#return value description#>
 */
+ (BOOL)isValidatePasswordLength:(NSString *)str;
@end
