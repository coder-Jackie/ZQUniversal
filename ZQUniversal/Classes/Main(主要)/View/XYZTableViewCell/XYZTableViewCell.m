//
//  XYZTableViewCell.m
//  beauty
//
//  Created by xieyan on 15-2-11.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import "XYZTableViewCell.h"
//#import "XYZMacroImport.h"

@interface XYZTableViewCell ()
@end
@implementation XYZTableViewCell









- (void)awakeFromNib {
    // Initialization code
//    NSObject
    self.showSepar = YES;
    
    
    if (!self.contentView.backgroundColor) {
        self.xyzBgColor = KWhiteColor;
    }else{
        self.xyzBgColor = self.contentView.backgroundColor;
    }
    
    
    
    
//    if (IsiOS8_OR_Higher) {
//        
//    }else{
//        self.xyzBgColor = self.contentView.backgroundColor;
//    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self afterInit];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.originalWidth=self.contentView.xyzWidth*AdjustScale;
        self.showSepar = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        if (IsiOS8_OR_Higher) {
//            
//        }else{
//            self.xyzBgColor = self.contentView.backgroundColor;
//        }
        if (!self.contentView.backgroundColor) {
            self.xyzBgColor = KWhiteColor;
        }else{
            self.xyzBgColor = self.contentView.backgroundColor;
        }
        [self afterInit];
    }
    return self;
}

-(void)afterInit{
    
}

-(void)setXyzBgColor:(UIColor *)xyzBgColor{
    _xyzBgColor = xyzBgColor;
    [self setNeedsDisplay];
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    if (self.xyzBgColor) {
        [self.xyzBgColor set];
        CGContextFillRect(ctx, CGRectMake(0, -1, rect.size.width, rect.size.height+3));
    }
    if (self.showSepar) {
        CGContextSetStrokeColorWithColor(ctx, [UIColor colorWithWhite:0.902 alpha:1.000].CGColor);
        CGContextMoveToPoint(ctx, 0, rect.size.height);
        CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
        CGContextStrokePath(ctx);
    }
    
}
-(void)setBackgroundColor:(UIColor *)backgroundColor{
    if (!self.xyzBgColor) {
        [super setBackgroundColor:backgroundColor];
    }
}

-(NSDictionary*)textAttributeFont:(NSInteger)font color:(UIColor*)color{
    return @{NSFontAttributeName:[UIFont systemFontOfSize:font],NSForegroundColorAttributeName:color};
}
@end


@implementation UIView (XYZ)

+(CGFloat)xyzCellHeight:(id)message width:(CGFloat)width{return 10;}
@end
