//
//  ZQPopMenu.h
//  YiMiApp
//
//  Created by CoderZQ on 2017/6/5.
//  Copyright © 2017年 YiMi. All rights reserved.
//  这个是封装带有箭头向下的弹窗载体.

#import <UIKit/UIKit.h>

typedef enum {
    ZQPopMenuArrowPositionCenter = 0,  //箭头向下靠左
    ZQPopMenuArrowPositionLeft = 1,   //箭头向下靠左
    ZQPopMenuArrowPositionRight = 2,  //箭头向下靠左
    ZQPopMenuArrowPositionUpRight = 3  //箭头向上靠右
} ZQPopMenuArrowPosition;

@class ZQPopMenu;

@protocol ZQPopMenuDelegate <NSObject>

@optional
- (void)popMenuDidDismissed:(ZQPopMenu *)popMenu;
@end

@interface ZQPopMenu : UIView
@property (nonatomic, weak) id<ZQPopMenuDelegate> delegate;

@property (nonatomic, assign, getter = isDimBackground) BOOL dimBackground;

@property (nonatomic, assign) ZQPopMenuArrowPosition arrowPosition;

/**
 *  初始化方法
 */
- (instancetype)initWithContentView:(UIView *)contentView;
+ (instancetype)popMenuWithContentView:(UIView *)contentView;

/**
 *  设置菜单的背景图片
 */
- (void)setBackground:(UIImage *)background;

/**
 *  显示菜单
 */
- (void)showInRect:(CGRect)rect;

/**
 *  关闭菜单
 */
- (void)dismiss;
@end
