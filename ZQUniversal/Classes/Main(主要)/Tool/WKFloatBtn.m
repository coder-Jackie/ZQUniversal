//
//  WKFloatBtn.m
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/29.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import "WKFloatBtn.h"


@interface WKFloatBtn()

@property (weak, nonatomic) IBOutlet UIButton *floatBtn;
@property (weak, nonatomic) IBOutlet UIImageView *voiceIv;

@end

@implementation WKFloatBtn

+ (instancetype)floatBtn
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
//    self.voiceIv.userInteractionEnabled = NO;
    
    
    
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-20));
        make.bottom.equalTo(@(-(KSafeAreaBottomHeight + 28 + 49)));
        make.size.mas_equalTo(CGSizeMake(54, 54));
    }];
    
    self.layer.cornerRadius = self.width/2;
    self.layer.masksToBounds = YES;
    
}


/**
 *  显示方法 不需初始化,直接 类名+ show 即可
 */
- (void)show
{
    self.hidden = NO;
    
}

/**
 *  隐藏方法
 */
- (void)hide
{
    self.hidden = YES;
}

- (IBAction)btnAction:(UIButton *)sender {
    
    ZQLog(@"悬浮按钮点击了");
    
}
@end
