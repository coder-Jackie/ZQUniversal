//
//  ZQSystemInfo.m
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/22.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import "ZQSystemInfo.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <sys/sysctl.h>
#import <UIKit/UIKit.h>
#import <net/if.h>



#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"


@implementation ZQSystemInfo

+ (NSString *)getIpAddresses{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL)
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}



#pragma mark - 获取设备当前网络IP地址
+ (NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    //NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         //筛选出IP地址格式
         if([self isValidatIP:address]) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

+ (BOOL)isValidatIP:(NSString *)ipAddress {
    if (ipAddress.length == 0) {
        return NO;
    }
    NSString *urlRegEx = @"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:0 error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:ipAddress options:0 range:NSMakeRange(0, [ipAddress length])];
        
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            NSString *result=[ipAddress substringWithRange:resultRange];
            //输出结果
            NSLog(@"%@",result);
            return YES;
        }
    }
    return NO;
}

+ (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}



+(NSString*)getCarrierInfo{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSString *mCarrier = [NSString stringWithFormat:@"%@",[carrier carrierName]];
    NSString *mConnectType = [[NSString alloc] initWithFormat:@"%@",info.currentRadioAccessTechnology];
    return [NSString stringWithFormat:@"%@:%@",mCarrier,mConnectType];
}

+ (NSString*)fetchSSIDInfo
{
    NSArray *ifs = (id)CFBridgingRelease(CNCopySupportedInterfaces());
    NSMutableString* str = [NSMutableString new];
    for (NSString *ifnam in ifs) {
        NSDictionary* info = (NSDictionary*)CFBridgingRelease(CNCopyCurrentNetworkInfo((CFStringRef)ifnam));
        if (info && [info count]) {
            [str appendFormat:@"%@",info[@"SSID"]];
        }
    }
    return str;
}

+(NSString*)getAppBuildVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}
+(NSString *)getAppVersion{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+(NSString *)getDeviceModel{
    
    return [NSString stringWithFormat:@"iOS%@:%@", [[UIDevice currentDevice] systemVersion],[self getCurrentDeviceModel]];
    
}

+(NSString *)getSysInfo{
    return [NSString stringWithFormat:@"iOS%@", [[UIDevice currentDevice] systemVersion]];
}
//获取格式化时间
+ (NSString *)getTimeStemp {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];//创建一个日期格式化器
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];//指定转date得日期格式化形HH必须大写不然会出现2017062608:12:32这情况
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
    //    NSDate *date = [NSDate date];
    //
    //    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //
    //
    //    [formatter setDateStyle:NSDateFormatterMediumStyle];
    //
    //    [formatter setTimeStyle:NSDateFormatterShortStyle];
    //
    //    [formatter setDateFormat:@"yyyyMMddHHmmss"];//YYYYMMddhhmmss
    //    NSString *DateTime = [formatter stringFromDate:date];
    //    return DateTime;
    //    return  [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
}
//@"yyyy-MM-dd HH:mm:ss"
+(NSString *)getNowTimeFor_Time {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];//创建一个日期格式化器
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//指定转date得日期格式化形HH必须大写不然会出现2017062608:12:32这情况
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

+(NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    NSString* deviceName = @"";
    
    if ([platform isEqualToString:@"iPhone1,1"]) deviceName = @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) deviceName = @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) deviceName = @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) deviceName = @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) deviceName = @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) deviceName = @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) deviceName = @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) deviceName = @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) deviceName = @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) deviceName = @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) deviceName = @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) deviceName = @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) deviceName = @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,2"]) deviceName = @"iPhone 6 (A1549/A1586)";
    if ([platform isEqualToString:@"iPhone7,1"]) deviceName = @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone8,1"]) deviceName = @"iPhone 6s (A1633/A1688/A1691/A1700)";
    if ([platform isEqualToString:@"iPhone8,2"]) deviceName = @"iPhone 6s Plus (A1634/A1687/A1690/A1699)";
    if ([platform isEqualToString:@"iPhone9,1"]) deviceName = @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) deviceName = @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"]) deviceName = @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"]) deviceName = @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"]) deviceName = @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"]) deviceName = @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"]) deviceName = @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"]) deviceName = @"iPhone X";
    
    //iPod Touch
    if ([platform isEqualToString:@"iPod1,1"])   deviceName = @"iPod Touch (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   deviceName = @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   deviceName = @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   deviceName = @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   deviceName = @"iPod Touch 5G (A1421/A1509)";
    if ([platform isEqualToString:@"iPod7,1"])   deviceName = @"iPod Touch 6G (A1574)";
    
    //iPad
    if ([platform isEqualToString:@"iPad1,1"])   deviceName = @"iPad (A1219/A1337)";
    if ([platform isEqualToString:@"iPad2,1"])   deviceName = @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   deviceName = @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   deviceName = @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   deviceName = @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad3,1"])   deviceName = @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   deviceName = @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   deviceName = @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   deviceName = @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   deviceName = @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   deviceName = @"iPad 4 (A1460)";
    
    //iPad Air
    if ([platform isEqualToString:@"iPad4,1"])   deviceName = @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   deviceName = @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   deviceName = @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad5,3"])   deviceName = @"iPad Air 2 (A1566)";
    if ([platform isEqualToString:@"iPad5,4"])   deviceName = @"iPad Air 2 (A1567)";
    
    //iPad mini
    if ([platform isEqualToString:@"iPad2,5"])   deviceName = @"iPad mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   deviceName = @"iPad mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   deviceName = @"iPad mini 1G (A1455)";
    if ([platform isEqualToString:@"iPad4,4"])   deviceName = @"iPad mini 2 (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   deviceName = @"iPad mini 2 (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   deviceName = @"iPad mini 2 (A1491)";
    if ([platform isEqualToString:@"iPad4,7"])   deviceName = @"iPad mini 3 (A1599)";
    if ([platform isEqualToString:@"iPad4,8"])   deviceName = @"iPad mini 3 (A1600)";
    if ([platform isEqualToString:@"iPad4,9"])   deviceName = @"iPad mini 3 (A1601)";
    if ([platform isEqualToString:@"iPad5,1"])   deviceName = @"iPad mini 4 (A1538)";
    if ([platform isEqualToString:@"iPad5,2"])   deviceName = @"iPad mini 4 (A1550)";
    
    if ([platform isEqualToString:@"i386"])      deviceName = @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    deviceName = @"iPhone Simulator";
    return [platform stringByAppendingFormat:@":%@",deviceName];
}



+ (NSString *)getNetWorkStates{
    
        UIApplication *app = [UIApplication sharedApplication];
        NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    
        NSString *state = @"";
        int netType = 0;
        //获取到网络返回码
        for (id child in children) {
            if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
                //获取到状态栏
                netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
    
                switch (netType) {
                    case 0:
                        state = @"无网络";
                        //无网模式
                        break;
                    case 1:
                        state =  @"2G";
                        break;
                    case 2:
                        state =  @"3G";
                        break;
                    case 3:
                        state =   @"4G";
                        break;
                    case 5:
                    {
                        state =  @"WIFI";
                        break;
                    default:
                        break;
                    }
                }
            }
        }
        return state;
}



@end
