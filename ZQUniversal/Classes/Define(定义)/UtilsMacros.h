//
//  UtilsMacros.h
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/17.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#ifndef UtilsMacros_h
#define UtilsMacros_h

// 这里还需修改
#define UMAppKey (([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)? @"5b0bafa4b27b0a04cd0000c8":@"5b0bb060f29d9850ff0000d3")
#define UMAppSecret (([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)? @"3sbdpxzsc3mm10j5n2wyo5vsh7at5axv":@"kuhhlx5vywgkfhz8wjde0jv1ya0kmnn2")


//获取系统对象
#define kApplication        [UIApplication sharedApplication]
#define kAppWindow          [UIApplication sharedApplication].delegate.window
#define kAppDelegate        [AppDelegate shareAppDelegate]
#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]


// LOG
#ifdef DEBUG
#define ZQLog(...) NSLog(@"%s第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define ZQLog(...)
#endif


// 颜色宏定义
#define KClearColor        [UIColor clearColor]
#define KWhiteColor        [UIColor whiteColor]
#define KBlackColor        [UIColor blackColor]
#define KGrayColor         [UIColor grayColor]
#define KGray2Color        [UIColor lightGrayColor]
#define KBlueColor         [UIColor blueColor]
#define KRedColor          [UIColor redColor]
#define KRandomColor       [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
#define KRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define KColorHex(__HEX__) [UIColor colorWithHexString:__HEX__]
// 主题色
#define KColorTheme     [UIColor colorWithHexString:@"ff6700"]

// 主题色
#define KColorGlobal    [UIColor colorWithHexString:@"6b56c7"]
// 分割线
#define KColorSeparater [UIColor colorWithHexString:@"d9d9d9"]
//导航栏颜色
#define KNavBgColor  [UIColor colorWithHexString:@"00AE68"]
//默认页面背景色
#define KViewBgColor [UIColor colorWithHexString:@"f2f2f2"]
// 默认字号12
#define KFont12 [UIFont systemFontOfSize:12.0f]


/*****************  屏幕适配  ******************/
#define iphoneX   (KScreenH == 812)
#define iphone6p  (KScreenH == 736)
#define iphone6   (KScreenH == 667)
#define iphone5   (KScreenH == 568)
#define iphone4   (KScreenH == 480)
#define KSafeAreaTopHeight    (KScreenH == 812.0 ? 88 : 64)
#define KSafeAreaBottomHeight (KScreenH == 812.0 ? 34 : 0)

#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kTopHeight (kStatusBarHeight + kNavBarHeight)


#define IS_IPHONE  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPAD    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)



//获取屏幕宽高
#define KScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define KScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreen_Bounds [UIScreen mainScreen].bounds

#define Iphone6ScaleWidth KScreenWidth/375.0
#define Iphone6ScaleHeight KScreenHeight/667.0
//根据ip6的屏幕来拉伸
#define kRealValue(with) ((with)*(KScreenWidth/375.0f))

//强弱引用
#define kWeakSelf(type)  __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;
#define WEAKSELF __weak typeof(self) weakSelf = self

//View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

// 当前系统版本
#define KCurrentSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]

#endif /* UtilsMacros_h */
