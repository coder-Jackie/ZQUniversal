//
//  UIImage+Extension.h
//  01-QQ聊天布局
//
//  Created by apple on 14-4-2.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
+ (UIImage *)resizableImage:(NSString *)name;


/**
 返回一张灰度图片
 */
+ (UIImage*)getGrayImage:(UIImage*)sourceImage;


/**
 根据当前图形,和传入的图片尺寸,设置图片圆角效果.
 */
- (void)zq_cornerImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor completion:(void(^)(UIImage *image))completion;

@end
