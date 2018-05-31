//
//  CXUMstatistics.m
//  YiMiApp
//
//  Created by 钱浩 on 15/12/30.
//  Copyright © 2015年 xieyan. All rights reserved.
//

#import "CXUMstatistics.h"
//#import <UMMobClick/MobClick.h>

#import <MobileCoreServices/MobileCoreServices.h>

#import <UMAnalytics/MobClick.h>
//#import "XYZImport.h"
@implementation CXUMstatistics


+(void)AnalyticStart{

//    #ifdef DEBUG
//        return;
//    #endif
    [MobClick setScenarioType:E_UM_GAME|E_UM_DPLUS];
    return;
}

+(void)SignInWithUserId:(NSString *)user_id{
    [MobClick profileSignInWithPUID:user_id];
    return;
}
+(void)SignInWithUserId:(NSString *)user_id provider:(NSString *)provider{
    [MobClick profileSignInWithPUID:user_id provider:provider];
    return;
}
+(void)SignOff{
    [MobClick profileSignOff];
    return;
}

/// 在viewWillAppear调用,才能够获取正确的页面访问路径、访问深度（PV）的数据
+ (void)beginLogPageView:(__unsafe_unretained Class)pageView{
    [MobClick beginLogPageView:NSStringFromClass(pageView)];
    return;
}

/// 在viewDidDisappeary调用，才能够获取正确的页面访问路径、访问深度（PV）的数据
+ (void)endLogPageView:(__unsafe_unretained Class)pageView{
    [MobClick endLogPageView:NSStringFromClass(pageView)];
    return;
}

+(void)countEvent:(NSString *)eventId{
    [MobClick event:eventId];
    return;
}

+(void)countEvent:(NSString *)eventId attributes:(NSDictionary *)attributes counter:(int)number{
    [MobClick event:eventId attributes:attributes counter:number];
    return;
}

+(void)beginEvent:(NSString *)eventId{
    [MobClick beginEvent:eventId];
    return;
}

+(void)endEvent:(NSString *)eventId{
    [MobClick endEvent:eventId];
    return;
}

+(void)beginEvent:(NSString *)eventId primarykey :(NSString *)keyName attributes:(NSDictionary *)attributes{
    [MobClick beginEvent:eventId primarykey:keyName attributes:attributes];
    return;
}

+ (void)event:(NSString *)eventId durations:(int)millisecond{
    [MobClick event:eventId durations:millisecond];
    return;
}

+ (void)event:(NSString *)eventId attributes:(NSDictionary *)attributes durations:(int)millisecond{
    [MobClick event:eventId attributes:attributes durations:millisecond];
    return;
}

+(void)loginUserCount:(NSString *)userName{
    NSMutableDictionary * dict=[[NSMutableDictionary alloc]initWithContentsOfFile:[CXUMstatistics filePath]];
   
    if (![[dict objectForKey:@"UM"]isEqualToString:[CXUMstatistics dateTime]]) {
        [CXUMstatistics countEvent:@"login_peopleCount"];
        NSMutableDictionary * dictPath=[NSMutableDictionary dictionary];
        [dictPath setObject:[CXUMstatistics dateTime] forKey:@"UM"];
        [dictPath setObject:userName forKey:@"userName"];
        [dictPath writeToFile:[CXUMstatistics filePath] atomically:YES];
    }else{
        if (![[dict objectForKey:@"userName"]isEqualToString:userName]) {
            [dict setObject:userName forKey:@"userName"];
            [CXUMstatistics countEvent:@"login_peopleCount"];
            NSLog(@"%@111",dict);
        }
    }
}
+(NSString *)filePath{
    NSString * path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"UMTest.plist"];
    return path;
}
+(NSString *)dateTime{
    NSDate * date=[[NSDate alloc]init];
    return [date stringDate];
}

+(void)onLineUser:(NSString *)userName{

    NSMutableDictionary * dict=[[NSMutableDictionary alloc]initWithContentsOfFile:[CXUMstatistics filePath]];
    if (![[dict objectForKey:@"onLine"]isEqualToString:[CXUMstatistics dateTime]]) {
        [CXUMstatistics countEvent:@"activeUser"];
        [dict setObject:[CXUMstatistics dateTime] forKey:@"onLine"];
        [dict setObject:userName forKey:@"onLineName"];
    }else{
        if (![[dict objectForKey:@"onLineName"]isEqualToString:userName]) {
            [dict setObject:userName forKey:@"onLineName"];
            [CXUMstatistics countEvent:@"activeUser"];
            NSLog(@"%@",dict);
        }
    }
}



//+ (NSString * )macString{
//    int mib[6];
//    size_t len;
//    char *buf;
//    unsigned char *ptr;
//    struct if_msghdr *ifm;
//    struct sockaddr_dl *sdl;
//    
//    mib[0] = CTL_NET;
//    mib[1] = AF_ROUTE;
//    mib[2] = 0;
//    mib[3] = AF_LINK;
//    mib[4] = NET_RT_IFLIST;
//    
//    if ((mib[5] = if_nametoindex("en0")) == 0) {
//        printf("Error: if_nametoindex error\n");
//        return NULL;
//    }
//    
//    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
//        printf("Error: sysctl, take 1\n");
//        return NULL;
//    }
//    
//    if ((buf = malloc(len)) == NULL) {
//        printf("Could not allocate memory. error!\n");
//        return NULL;
//    }
//    
//    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
//        printf("Error: sysctl, take 2");
//        free(buf);
//        return NULL;
//    }
//    
//    ifm = (struct if_msghdr *)buf;
//    sdl = (struct sockaddr_dl *)(ifm + 1);
//    ptr = (unsigned char *)LLADDR(sdl);
//    NSString *macString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
//                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
//    free(buf);
//    
//    return macString;
//}
//
//+ (NSString *)idfaString {
//    
//    NSBundle *adSupportBundle = [NSBundle bundleWithPath:@"/System/Library/Frameworks/AdSupport.framework"];
//    [adSupportBundle load];
//    
//    if (adSupportBundle == nil) {
//        return @"";
//    }
//    else{
//        
//        Class asIdentifierMClass = NSClassFromString(@"ASIdentifierManager");
//        
//        if(asIdentifierMClass == nil){
//            return @"";
//        }
//        else{
//            
//            //for no arc
//            //ASIdentifierManager *asIM = [[[asIdentifierMClass alloc] init] autorelease];
//            //for arc
//            ASIdentifierManager *asIM = [[asIdentifierMClass alloc] init];
//            
//            if (asIM == nil) {
//                return @"";
//            }
//            else{
//                
//                if(asIM.advertisingTrackingEnabled){
//                    return [asIM.advertisingIdentifier UUIDString];
//                }
//                else{
//                    return [asIM.advertisingIdentifier UUIDString];
//                }
//            }
//        }
//    }
//}
//
//+ (NSString *)idfvString
//{
//    if([[UIDevice currentDevice] respondsToSelector:@selector( identifierForVendor)]) {
//        return [[UIDevice currentDevice].identifierForVendor UUIDString];
//    }
//    
//    return @"";
//}
@end
