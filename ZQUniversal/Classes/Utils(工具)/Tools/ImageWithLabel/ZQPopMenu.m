//
//  ZQPopMenu.m
//  YiMiApp
//
//  Created by CoderZQ on 2017/6/5.
//  Copyright © 2017年 YiMi. All rights reserved.
//

#import "ZQPopMenu.h"
#import "UIImage+Extension.h"
@interface ZQPopMenu()
@property (nonatomic, strong) UIView *contentView;
/**
 *  最底部的遮盖 ：屏蔽除菜单以外控件的事件
 */
@property (nonatomic, weak) UIButton *cover;
/**
 *  容器 ：容纳具体要显示的内容contentView
 */
@property (nonatomic, weak) UIImageView *container;
@end

@implementation ZQPopMenu
#pragma mark - 初始化方法
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /** 添加菜单内部的2个子控件 **/
        // 添加一个遮盖按钮
        UIButton *cover = [[UIButton alloc] init];
        cover.backgroundColor = [UIColor clearColor];
        [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cover];
        self.cover = cover;
        
        // 添加带箭头的菜单图片
        UIImageView *container = [[UIImageView alloc] init];
        container.userInteractionEnabled = YES;
        [self addSubview:container];
        self.container = container;
        
        // 默认箭头指向中间
        self.arrowPosition = ZQPopMenuArrowPositionCenter;
    }
    return self;
}

- (instancetype)initWithContentView:(UIView *)contentView
{
    if (self = [super init]) {
        self.contentView = contentView;
    }
    return self;
}

+ (instancetype)popMenuWithContentView:(UIView *)contentView
{
    return [[self alloc] initWithContentView:contentView];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.cover.frame = self.bounds;
}

#pragma mark - 内部方法
- (void)coverClick
{
    [self dismiss];
}

#pragma mark - 公共方法
- (void)setDimBackground:(BOOL)dimBackground
{
    _dimBackground = dimBackground;
    
    if (dimBackground) {
        self.cover.backgroundColor = [UIColor blackColor];
        self.cover.alpha = 0.3;
    } else {
        self.cover.backgroundColor = [UIColor clearColor];
        self.cover.alpha = 1.0;
    }
}

- (void)setArrowPosition:(ZQPopMenuArrowPosition)arrowPosition
{
    _arrowPosition = arrowPosition;
    
    switch (arrowPosition) {
        case ZQPopMenuArrowPositionCenter:  // 箭头向下
            //self.container.image = [UIImage resizedImage:@"popover_background"];
            
            self.container.image = [UIImage resizableImage:@"arrow-up-new"]; // appclass_xialatanchunew popover_background
            break;
            
        case ZQPopMenuArrowPositionLeft:
            //self.container.image = [UIImage resizedImage:@"popover_background_left"];
            self.container.image = [UIImage resizableImage:@"arrow-up-new"];
            break;
            
        case ZQPopMenuArrowPositionRight:
            //self.container.image = [UIImage resizedImage:@"popover_background_right"];
            self.container.image = [UIImage resizableImage:@"arrow-up-new"];
            break;
            
            
        case ZQPopMenuArrowPositionUpRight: {
            //self.container.image = [UIImage resizedImage:@"popover_background_right"];
            
            UIImage *image = [UIImage imageNamed:@"appclass_xialatanchunew"];
            image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(20,10,10,10) resizingMode:UIImageResizingModeStretch];
            self.container.image = image;
            //self.container.image = [UIImage resizableImage:@"appclass_xialatanchunew"];
            break;
        }
    }
}

- (void)setBackground:(UIImage *)background
{
    self.container.image = background;
}

- (void)showInRect:(CGRect)rect
{
    // 添加菜单整体到窗口身上
    //UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    self.frame = window.bounds;
    [window addSubview:self];
    
    // 设置容器的frame
    self.container.frame = rect;
    [self.container addSubview:self.contentView];
    
    // 设置容器里面内容的frame
//    CGFloat topMargin = 12;
//    CGFloat leftMargin = 5;
//    CGFloat rightMargin = 5;
//    CGFloat bottomMargin = 8;
    CGFloat topMargin;
    CGFloat bottomMargin;
    if (self.arrowPosition == ZQPopMenuArrowPositionUpRight) {
        topMargin = 15;
        bottomMargin = 5;
    } else {
        topMargin = 5;
        bottomMargin = 15;
    }
    
    //CGFloat topMargin = 15;
    CGFloat leftMargin = 5;
    CGFloat rightMargin = 5;
    //CGFloat bottomMargin = 15;
    
    self.contentView.top = topMargin;
    self.contentView.left = leftMargin;
    self.contentView.width = self.container.width - leftMargin - rightMargin;
    self.contentView.height = self.container.height - topMargin - bottomMargin;
}

- (void)dismiss
{
    if ([self.delegate respondsToSelector:@selector(popMenuDidDismissed:)]) {
        [self.delegate popMenuDidDismissed:self];
    }
    
    [self removeFromSuperview];
}
@end
