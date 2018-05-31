//
//  ZQBlankErrorView.h
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/30.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//  

#import <UIKit/UIKit.h>

typedef void(^WKBtnTapBlcok)(UIButton *sender);

@interface ZQBlankErrorView : UIView


+ (instancetype)blankErrorView;

/** 背景View */
@property (weak, nonatomic) IBOutlet UIView *bgView;

/** 图片Iv */
@property (weak, nonatomic) IBOutlet UIImageView *imgIv;
/** 标题Lb */
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
/** 点击按钮 */
@property (weak, nonatomic) IBOutlet UIButton *tapBtn;


@property (nonatomic, copy) WKBtnTapBlcok tapCallBack;

+ (ZQBlankErrorView *)showBlankErrorView:(UIView *)superView image:(UIImage *)image text:(NSString *)text btnTitle:(NSString *)title tapBlock:(WKBtnTapBlcok)tapBlock;
+ (ZQBlankErrorView *)showBlankErrorView:(UIView *)superView image:(UIImage *)image text:(NSString *)text btnTitle:(NSString *)title;
+ (ZQBlankErrorView *)showBlankErrorView:(UIView *)superView image:(UIImage *)image text:(NSString *)text;

+ (void)hideBlankErrorView:(UIView *)superView;
@end
