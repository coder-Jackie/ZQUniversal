//
//  WKHomeCellHeadView.h
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/22.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKHomeCellHeadView : UIView

+ (instancetype)homeCellHeadView;

/** 查看全部按钮点击block */
@property(nonatomic, copy) void(^allBtnAction)();

@end
