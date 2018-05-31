//
//  GLLoginReturnData.h
//  YiMiApp
//
//  Created by 关雷 on 15/9/28.
//  Copyright (c) 2015年 xieyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLLoginReturnData : NSObject

@property (strong, nonatomic) NSString *access_token;
@property (strong, nonatomic) NSString *profile_image_url;
@property (strong, nonatomic) NSString *screen_name;
@property (strong, nonatomic) NSString *location;

@property (weak, nonatomic  ) NSString * openid;
@property (weak, nonatomic  ) NSNumber * gender;
        
@end


@interface GLLoginReturnDataSina : NSObject

@property (strong, nonatomic) NSString *access_token;
@property (strong, nonatomic) NSString *profile_image_url;
@property (strong, nonatomic) NSString *screen_name;
@property (strong, nonatomic) NSString *location;

@property (weak, nonatomic  ) NSString * uid;
@property (weak, nonatomic  ) NSNumber * gender;

@end