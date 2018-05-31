//
//  ZQNavigationController.h
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/18.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZQNavigationController : UINavigationController

/** 返回按钮点击block */
@property (nonatomic, copy) void (^backBtnAciton)();

@end
