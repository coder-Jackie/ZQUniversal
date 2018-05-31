//
//  UIImage+ResizeImage.m
//  QQ聊天布局
//
//  Created by TianGe-ios on 14-8-20.
//  Copyright (c) 2014年 TianGe-ios. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "UIImage+ResizeImage.h"

@implementation UIImage (ResizeImage)

+ (UIImage *)resizeImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat imageW = image.size.width * 0.5;
    CGFloat imageH = image.size.height * 0.9;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW) resizingMode:UIImageResizingModeTile];
//    UIImage *retImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW) resizingMode:UIImageResizingModeTile];
//    UIImage *retImage2 = [image stretchableImageWithLeftCapWidth:imageW topCapHeight:imageH];
//    return retImage;
}
+(instancetype)imageWithColor:(UIColor*)color W:(CGFloat)Width H:(CGFloat)Height{
    CGSize imageSize = CGSizeMake(Width, Height);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;
}

+(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize{
    if (!image) {
        return nil;
    }
    UIImage* scaledImage = [image imageScaledToSize:newSize];
    if (!scaledImage) {
        scaledImage = image;
    }
    return scaledImage;
}
-(UIImage*)imageScaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage * newImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
