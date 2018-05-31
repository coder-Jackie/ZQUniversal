//
//  HSHeaderCellModel.h
//  HSSetTableViewCtrollerDemo
//
//  Created by hushaohui on 2017/6/9.
//  Copyright © 2017年 ZLHD. All rights reserved.
//

#import "HSCustomCellModel.h"


/**
 微信头像cell 模型
 */
@interface HSHeaderCellModel : HSCustomCellModel

/** 头像名称 */
@property(nonatomic, copy) NSString *headIVStr;

/** 头像Iv */
@property(nonatomic, strong) UIImage *headImg;

@end
