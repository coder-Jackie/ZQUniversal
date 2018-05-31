//
//  NSDate+String.h
//  YiMiApp
//
//  Created by xieyan on 16/1/5.
//  Copyright © 2016年 xieyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (String)
-(NSString*)stringDate;
-(NSString*)stringTime;
-(NSString*)stringFormate:(NSString*)formate;
+(NSDate*)dateOf:(NSString*)string formate:(NSString*)formate;
+ (NSString *)stringFormatteSecond:(NSInteger)totalSeconds;
@end
