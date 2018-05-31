//
//  DeepCopy.m
//  YiMiApp
//
//  Created by xieyan on 16/4/18.
//  Copyright © 2016年 xieyan. All rights reserved.
//

#import "DeepCopy.h"

BOOL StringIsBlank(NSString*str){
    if (str == nil || str == NULL) {
        return YES;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    NSString* nullstr = [str lowercaseString];
    if ([nullstr isEqualToString:@"null"]) {
        return YES;
    }
    if ([nullstr isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([nullstr isEqualToString:@"<null>"]) {
        return YES;
    }
    //去除字符串中的空格
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
@implementation NSArray (deepCopy)
-(NSMutableArray*)MutableDeepCopyToString:(BOOL)toString{
    NSMutableArray* muArray = self.mutableCopy;
    for (int i=0; i<self.count; i++) {
        NSObject* obj = self[i];
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary* subkeydic = [((NSDictionary*)obj) MutableDeepCopyToString:toString];
            [muArray replaceObjectAtIndex:i withObject:subkeydic];
        }else if ([obj isKindOfClass:[NSArray class]]){
            NSMutableArray* subkeyarray = [((NSArray*)obj) MutableDeepCopyToString:toString];
            [muArray replaceObjectAtIndex:i withObject:subkeyarray];
        }else{
            if (toString) {
                NSString* str = [NSString stringWithFormat:@"%@",obj];
                if (StringIsBlank(str)) {
                    str = @"";
                }
                [muArray replaceObjectAtIndex:i withObject:str];
            }
        }
    }
    return muArray;
}

@end


@implementation NSDictionary (deepCopy)


-(NSMutableDictionary*)MutableDeepCopyToString:(BOOL)toString{
    NSMutableDictionary* mudic = self.mutableCopy;
    [self enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary* subkeydic = [((NSDictionary*)obj) MutableDeepCopyToString:toString];
            [mudic setValue:subkeydic forKey:key];
        }else if ([obj isKindOfClass:[NSArray class]]){
            NSMutableArray* subkeyarray = [((NSArray*)obj) MutableDeepCopyToString:toString];
            [mudic setValue:subkeyarray forKey:key];
        }else{
            if (toString) {
                NSString* str = [NSString stringWithFormat:@"%@",obj];
                if (StringIsBlank(str)) {
                    str = @"";
                }
                [mudic setValue:str forKey:key];
            }
        }
    }];
    return mudic;
}
@end