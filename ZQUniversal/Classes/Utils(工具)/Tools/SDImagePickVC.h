//
//  SDImagePickVC.h
//  YiMiApp
//
//  Created by Yangsenkai on 2017/3/6.
//  Copyright © 2017年 YiMi. All rights reserved.
//

typedef NS_ENUM(NSUInteger, YIMIImagePickerDirection) {
    YIMIImagePickerDirectionPortrait,// 正常竖屏
    YIMIImagePickerDirectionLandscapeRight,
};

#import <UIKit/UIKit.h>

@interface SDImagePickVC : UIImagePickerController
/**  */
@property (nonatomic, assign) YIMIImagePickerDirection direction;
@end
