//
//  ZQCacheManager.m
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/22.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import "ZQCacheManager.h"

#import <YYCache.h>

static NSString *const DRAFTCACHENAME = @"DraftCache";

@interface ZQCacheManager()

@property(nonatomic, strong) YYCache *yycache;

@end


@implementation ZQCacheManager

+ (ZQCacheManager *)sharedInstance
{
    static ZQCacheManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
    
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *path = [cacheFolder stringByAppendingPathComponent:DRAFTCACHENAME];
        self.yycache = [[YYCache alloc] initWithPath:path];
    }
    return self;
}

- (BOOL)containsObjectFromKey:(NSString *)key {
    return [self.yycache containsObjectForKey:key];
}
- (void)removeCacheFromKey:(NSString *)key {
    [self.yycache containsObjectForKey:key withBlock:^(NSString *key, BOOL contains) {
        if (contains) {
            [self.yycache removeObjectForKey:key];
        }
    }];
}
- (void)removeAllCache {
    [self.yycache removeAllObjectsWithBlock:^{
        
    }];
}

- (void)setCacheFromObject:(id)obj toKey:(NSString *)key {
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:obj forKey:key];
    [archiver finishEncoding];
    [self.yycache setObject:data forKey:key withBlock:^{
        
    }];
}
- (id)readCacheFromKey:(NSString *)key {
    if ([self.yycache containsObjectForKey:key]) {
        id<NSCoding> object = [self.yycache objectForKey:key];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:(NSData *)object];
        id anObject = [unarchiver decodeObjectForKey:key];
        [unarchiver finishDecoding];
        
        return anObject;
    }
    return nil;
}
- (void)readCacheFromKey:(NSString *)key callBlock:(void(^)(BOOL contains, id anObject))callBlock {
    [self.yycache containsObjectForKey:key withBlock:^(NSString *key, BOOL contains) {
        if (contains) {
            [self.yycache objectForKey:key withBlock:^(NSString *key, id<NSCoding> object) {
                @try {
                    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:(NSData *)object];
                    id anObject = [unarchiver decodeObjectForKey:key];
                    [unarchiver finishDecoding];
                    callBlock(contains,anObject);
                }
                @catch (NSException *exception) {
                    callBlock(NO,nil);
                }
                @finally {
                    callBlock(NO,nil);
                }
            }];
        }else {
            callBlock(contains,nil);
        }
    }];
}

/*
 *  just text
 *  used in nsobject nsdictionary nsarray uiimage and  entity
 */
- (void)cacheTest {
    YYCache *cache = [[YYCache alloc] initWithName:@"cacheTest"];
    NSLog(@"cache.name = %@",cache.name);
    [cache containsObjectForKey:@"username" withBlock:^(NSString *key, BOOL contains) {
        if (contains) {
            [cache objectForKey:key withBlock:^(NSString *key, id<NSCoding> object) {
                [cache removeObjectForKey:key];
                NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:(NSData *)object];
                id anObject = [unarchiver decodeObjectForKey:key];
                [unarchiver finishDecoding];
                //                id anObject = [NSKeyedUnarchiver unarchiveObjectWithData: (NSData *)object];
                
                
                NSLog(@"%@",anObject);
            }];
        }else {
            //            ShareMsgEntity *ent = [[ShareMsgEntity alloc] init];
            //            ent.type = 1;
            //            ent.title = @"这是一个测试";
            //            ent.desc = @"asdhlahslflk啊手机带回家啊还是解放军啊舒服哈说郝飞家";
            //            ent.img_url = @"http://www.baidu.com";
            //            ent.dest_id = @"12";
            
            NSMutableDictionary *ent = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                        @"jahnny",@"name",
                                        [NSNumber numberWithInteger:1],@"sex",
                                        @"26",@"age",
                                        UIImagePNGRepresentation([UIImage imageNamed:@"勾小手.png"]),@"image",nil];
            
            //            NSData *archiveCarPriceData = [NSKeyedArchiver archivedDataWithRootObject:ent];
            
            NSMutableData *data = [[NSMutableData alloc] init];
            NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
            [archiver encodeObject:ent forKey:key];
            [archiver finishEncoding];
            
            
            
            [cache setObject:data forKey:@"username" withBlock:^{
                
            }];
        }
    }];
}


@end
