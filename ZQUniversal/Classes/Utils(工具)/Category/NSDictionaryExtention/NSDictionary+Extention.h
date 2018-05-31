//
//  NSDictionary+Extention.h
//  YiMiApp
//
//  Created by 王建伟 on 16/7/25.
//  Copyright © 2016年 xieyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extention)

/**
 
 * @brief 把格式化的JSON格式的字符串转换成字典
 
 * @param jsonString JSON格式的字符串
 
 * @return 返回字典
 
 */

+(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 
 * @brief 把字典转换成JSON格式的字符串
 
 * @param dic 字典
 
 * @return 返回JSON格式的字符串
 
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

/**
 字典深拷贝
 */
-(NSMutableDictionary *)mutableDeepCopy;

@end
