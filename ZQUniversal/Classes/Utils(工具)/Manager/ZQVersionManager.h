//
//  ZQVersionManager.h
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/29.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZQVersionManager : NSObject


+ (void)checkVersionURL:(NSString *)url param:(NSDictionary *)param;


/**
 获取当前是否是最新版本
 */
+ (BOOL)isNewVersionURL:(NSString *)url param:(NSDictionary *)param;
@end
