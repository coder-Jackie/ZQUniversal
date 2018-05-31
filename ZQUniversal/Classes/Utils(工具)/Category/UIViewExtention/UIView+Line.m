//
//  UIView+Line.m
//  YiMiApp
//
//  Created by xieyan on 15/11/11.
//  Copyright © 2015年 xieyan. All rights reserved.
//

#import "UIView+Line.h"

@implementation UIView (Line)
-(void)xyzShowBorder:(UIColor*)bordercolor cornerRadius:(CGFloat)radius{
    self.layer.borderWidth=1;
    self.layer.cornerRadius=radius;
    if (bordercolor) {
        self.layer.borderColor=bordercolor.CGColor;
    }else{
        self.layer.borderColor=[UIColor grayColor].CGColor;
    }
    self.layer.masksToBounds=YES;
}
@end
