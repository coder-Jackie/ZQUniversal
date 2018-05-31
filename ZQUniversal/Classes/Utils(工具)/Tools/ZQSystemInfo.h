//
//  ZQSystemInfo.h
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/22.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZQSystemInfo : NSObject

+(instancetype)Instance;
// 获取设备当前网络IP地址 不包含流量的
+ (NSString *)getIpAddresses;
// 获取设备当前网络IP地址 包含流量的
+ (NSString *)getIPAddress:(BOOL)preferIPv4;
+ (NSString*)getCarrierInfo;
+ (NSString*)getAppBuildVersion;//2202
+ (NSString *)getAppVersion;//2.2.2202
+ (NSString *)getDeviceModel;
+ (NSString*)fetchSSIDInfo;
+ (NSString *)getNetWorkStates;

+(NSString *)getSysInfo;
+ (NSString *)getTimeStemp;
//@"yyyy-MM-dd HH:mm:ss"
+(NSString *)getNowTimeFor_Time;

@end
