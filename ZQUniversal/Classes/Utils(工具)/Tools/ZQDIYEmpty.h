//
//  ZQDIYEmpty.h
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/25.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import "LYEmptyView.h"

@interface ZQDIYEmpty : LYEmptyView

+ (instancetype)diyNoDataEmpty;

+ (instancetype)diyNoNetworkEmptyWithTarget:(id)target action:(SEL)action;

+ (instancetype)diyCustomEmptyViewWithTarget:(id)target action:(SEL)action;

@end
