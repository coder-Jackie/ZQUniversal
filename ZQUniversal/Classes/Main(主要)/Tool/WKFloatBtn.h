//
//  WKFloatBtn.h
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/29.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKFloatBtn : UIView
+ (instancetype)floatBtn;

/**
 *  显示方法 不需初始化,直接 类名+ show 即可
 */
- (void)show;

/**
 *  隐藏方法
 */
- (void)hide;

@end
