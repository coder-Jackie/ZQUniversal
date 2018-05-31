//
//  WKHomeCell.m
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/22.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import "WKHomeCell.h"

@interface WKHomeCell()


// 下划线LB
@property (weak, nonatomic) IBOutlet UILabel *lineLb;

@end


@implementation WKHomeCell

+ (instancetype)homeCell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // 
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:self.lineLb.text attributes:attribtDic];
    self.lineLb.attributedText = attribtStr;
}



@end
