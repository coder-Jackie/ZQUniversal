//
//  NSString+Number.m
//  YiMiApp
//
//  Created by xieyan on 16/3/11.
//  Copyright © 2016年 xieyan. All rights reserved.
//

#import "NSString+Number.h"

@implementation NSString (Number)
-(NSString*)NumberAdd_Int:(NSInteger)number{
    return [NSString stringWithFormat:@"%ld",[self integerValue]+number];
}
-(NSString*)NumberAdd_String:(NSString*)number{
    return [NSString stringWithFormat:@"%ld",[self integerValue]+[number integerValue]];
}
@end
