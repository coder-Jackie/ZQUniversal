//
//  ZQBlankErrorView.m
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/30.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import "ZQBlankErrorView.h"

@interface ZQBlankErrorView()

@end

@implementation ZQBlankErrorView

+ (instancetype)blankErrorView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
}


+ (ZQBlankErrorView *)showBlankErrorView:(UIView *)superView image:(UIImage *)image text:(NSString *)text btnTitle:(NSString *)title tapBlock:(WKBtnTapBlcok)tapBlock
{
    
    [self hideBlankErrorView:superView];
    
    ZQBlankErrorView *errorView = [self blankErrorView];
    errorView.frame = superView.bounds;
    errorView.tag = 1000;
    errorView.hidden = NO;
    
    [errorView setImage:image];
    [errorView setText:text];
    
    if ([NSString isBlank:title]) {
        errorView.tapBtn.hidden = YES;
    }else {
        [errorView setButtonTitle:title];
    }
    
    if (tapBlock) {
        [errorView addBlankTapCallBack:tapBlock];
    }
    
    [superView addSubview:errorView];
    return errorView;
    
}

+ (ZQBlankErrorView *)showBlankErrorView:(UIView *)superView image:(UIImage *)image text:(NSString *)text btnTitle:(NSString *)title
{
    return [self showBlankErrorView:superView image:image text:text btnTitle:title tapBlock:nil];
    
}
+ (ZQBlankErrorView *)showBlankErrorView:(UIView *)superView image:(UIImage *)image text:(NSString *)text
{
    return [self showBlankErrorView:superView image:image text:text btnTitle:nil tapBlock:nil];
}


- (void)addBlankTapCallBack:(WKBtnTapBlcok)callBack {
    self.tapCallBack = [callBack copy];
//    UITapGestureRecognizer* tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
//    [self addGestureRecognizer:tapges];
    
}

- (void)setImage:(UIImage *)image
{
    self.imgIv.image = image;
    [self layoutSubviews];
    [self layoutIfNeeded];
    
}


- (void)setText:(NSString *)text
{
    self.titleLb.text = text;
    [self layoutSubviews];
    [self layoutIfNeeded];
}

- (void)setButtonTitle:(NSString *)title {
    self.tapBtn.hidden = NO;
    [_tapBtn setTitle:title forState:UIControlStateNormal];
    [self layoutSubviews];
    [self layoutIfNeeded];
}

// 按钮点击事件
- (IBAction)tapBtnAction:(UIButton *)sender {
    
    if (self.tapCallBack) {
        self.tapCallBack(sender);
    }
}



+ (void)hideBlankErrorView:(UIView *)superView
{
    ZQBlankErrorView *errorView = [superView viewWithTag:1000];
    errorView.hidden = YES;
    [errorView removeFromSuperview];
}
@end
