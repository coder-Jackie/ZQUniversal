//
//  DeepCopy.h
//  YiMiApp
//
//  Created by xieyan on 16/4/18.
//  Copyright © 2016年 xieyan. All rights reserved.
//
#import <Foundation/Foundation.h>
@interface NSArray (deepCopy)
-(NSMutableArray*)MutableDeepCopyToString:(BOOL)toString;
@end

@interface NSDictionary (deepCopy)
-(NSMutableDictionary*)MutableDeepCopyToString:(BOOL)toString;
@end
