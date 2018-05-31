//
//  WKHomeCellHeadView.m
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/22.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import "WKHomeCellHeadView.h"

@implementation WKHomeCellHeadView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

+ (instancetype)homeCellHeadView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"WKHomeCellHeadView" owner:nil options:nil] lastObject];
}


// 查看全部按钮点击
- (IBAction)allBtnAction:(UIButton *)sender {
    if (self.allBtnAction) {
        self.allBtnAction();
    }
    
}

@end
