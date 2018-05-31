//
//  CXUMstatistics.h
//  YiMiApp
//
//  Created by 钱浩 on 15/12/30.
//  Copyright © 2015年 xieyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXUMstatistics : NSObject

//启动友盟统计 默认是BATCH 下次启动时发送上次的统计数据
+(void)AnalyticStart;

//账号统计
/**
 *  友盟在统计用户时以设备为标准，如果需要统计应用自身的账号，请使用以下接口
 
 PUID：用户账号ID.长度小于64字节
 Provider：账号来源。如果用户通过第三方账号登陆，可以调用此接口进行统计。不能以下划线"_"开头，使用大写字母和数字标识，长度小于32 字节 ; 如果是上市公司，建议使用股票代码。
 */
+(void)SignInWithUserId:(NSString *)user_id;

+(void)SignInWithUserId:(NSString *)user_id provider:(NSString *)provider;
//账号登出需要调用此接口，调用之后不在发送账号相关内容
+(void)SignOff;

//启动页面统计  自动页面时长统计, 开始记录某个页面展示时长
/// 在viewWillAppear调用,才能够获取正确的页面访问路径、访问深度（PV）的数据
+ (void)beginLogPageView:(__unsafe_unretained Class)pageView;

//自动页面时长统计, 结束记录某个页面展示时长
/// 在viewDidDisappeary调用，才能够获取正确的页面访问路径、访问深度（PV）的数据
+ (void)endLogPageView:(__unsafe_unretained Class)pageView;

//自定义事件

//计数事件  统计发生次数
/**
 *  @param eventId eventId 网站上注册的事件Id.
    @param  attributes 为当前事件的属性和取值（键值对），不能为空
    @param
 */
+(void)countEvent:(NSString *)eventId;
//考虑事件在不同属性上的取值，可以调用如下方法：
+(void)countEvent:(NSString *)eventId attributes:(NSDictionary*)attributes;


//计算事件  统计一个数值类型的连续变量（该变量必须为整数），用户每次触发的数值的分布情况，如事件持续时间、每次付款金额等
//付款金额
+(void)countEvent:(NSString *)eventId attributes:(NSDictionary *)attributes counter:(int)number;

//时长统计

/**
 *  beginEvent,endEvent要配对使用,也可以自己计时后通过durations参数传递进来
 @param  label 分类标签。不同的标签会分别进行统计，方便同一事件的不同标签的对比,为nil或空字符串时后台会生成和eventId同名的标签.
 @param  primarykey 这个参数用于和event_id一起标示一个唯一事件，并不会被统计；对于同一个事件在beginEvent和endEvent 中要传递相同的eventId 和 primarykey
 @param millisecond 自己计时需要的话需要传毫秒进来
 */
+(void)beginEvent:(NSString *)eventId;

+(void)endEvent:(NSString *)eventId;

+(void)beginEvent:(NSString *)eventId primarykey :(NSString *)keyName attributes:(NSDictionary *)attributes;

+ (void)event:(NSString *)eventId durations:(int)millisecond;

+ (void)event:(NSString *)eventId attributes:(NSDictionary *)attributes durations:(int)millisecond;


+(void)loginUserCount:(NSString *)userName;
+(void)onLineUser:(NSString *)userName;




@end
