//
//  ZQCacheManager.h
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/22.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import <Foundation/Foundation.h>


static NSString *const UserInfoNew          = @"UserInfoNew2";
static NSString *const OldCacheKey          = @"OldCacheKey";
static NSString *const OldSettingModelKey   = @"OldSettingModelKey";
static NSString *const OldAVControlModelKey = @"OldAVControlModelKey";
static NSString *const GoodIPList           = @"GoodIPList";
static NSString *const LessonPlanList       = @"LessonPlanList";


#define ZQCacheMgr (ZQCacheManager *)[ZQCacheManager sharedInstance]


@interface ZQCacheManager : NSObject

+ (ZQCacheManager *)sharedInstance;

/** 某个key的cache是否存在 */
- (BOOL)containsObjectFromKey:(NSString *)key;

/** 删除某个key的cache */
- (void)removeCacheFromKey:(NSString *)key;

/** 删除全部cache */
- (void)removeAllCache;

/** 为某个obj设置cache的key */
- (void)setCacheFromObject:(id)obj toKey:(NSString *)key;

/** 读取某个key的cache信息 */
- (id)readCacheFromKey:(NSString *)key;

/** 读取某个key的cache信息 @param  callBlock     加载完成事件处理 contains为yes表示成功 */
- (void)readCacheFromKey:(NSString *)key callBlock:(void(^)(BOOL contains, id anObject))callBlock;

@end
