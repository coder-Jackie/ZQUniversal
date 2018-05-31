//
//  UIView+Hierarchy.m
//  YiMiApp
//
//  Created by xieyan on 15/11/11.
//  Copyright © 2015年 xieyan. All rights reserved.
//

#import "UIView+Hierarchy.h"

@implementation UIView (Hierarchy)
-(void)removeAllSUbview{
    for (UIView* view in self.subviews) {
        if (view!=self) {
            [view removeFromSuperview];
        }
    }
}
@end
