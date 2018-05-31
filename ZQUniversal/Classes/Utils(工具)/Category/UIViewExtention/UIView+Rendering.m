//
//  UIView+Rendering.m
//  YiMiApp
//
//  Created by xieyan on 15/11/16.
//  Copyright © 2015年 xieyan. All rights reserved.
//

#import "UIView+Rendering.h"

@implementation UIView (Rendering)
-(UIImage*)screenShotRect:(CGRect)frame{
    if(UIGraphicsBeginImageContextWithOptions != NULL)
    {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, YES, 1.0);
    } else {
        UIGraphicsBeginImageContext(self.frame.size);
    }
//    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 1);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef imageRef = viewImage.CGImage;
    CGImageRef imageRefRect = CGImageCreateWithImageInRect(imageRef, frame);
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    CGImageRelease(imageRefRect);
    return sendImage;
}
@end
