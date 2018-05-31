//
//  NSDate+String.m
//  YiMiApp
//
//  Created by xieyan on 16/1/5.
//  Copyright © 2016年 xieyan. All rights reserved.
//

#import "NSDate+String.h"

@implementation NSDate (String)
-(NSString*)stringDate{
    return [self stringFormate:@"yyyy-MM-dd"];
}
-(NSString*)stringTime{
    return [self stringFormate:@"HH-mm"];
}
-(NSString*)stringFormate:(NSString*)formate{
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:formate];
    NSString * dateTime=[formatter stringFromDate:self];
    return dateTime;
}
+(NSDate*)dateOf:(NSString*)string formate:(NSString*)formate{
    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:formate];
    NSDate * dateTime=[formatter dateFromString:string];
    return dateTime;
}
+ (NSString *)stringFormatteSecond:(NSInteger)totalSeconds
{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
}
@end
