//
//  ZQHTTPTool.h
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/18.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ZQRequestSucess)(id response,int code);
typedef void(^ZQRequestFailure)(NSError *error);

@interface ZQHTTPTool : NSObject

+ (void)GET:(NSString *)url params:(NSDictionary *)params success:(ZQRequestSucess)success failure:(ZQRequestFailure)failure;
+ (void)GET:(NSString *)url params:(NSDictionary *)params success:(ZQRequestSucess)success failure:(ZQRequestFailure)failure hudInView:(UIView *)view;


+ (void)POST:(NSString *)url params:(NSDictionary *)params success:(ZQRequestSucess)success failure:(ZQRequestFailure)failure;
+ (void)POST:(NSString *)url params:(NSDictionary *)params success:(ZQRequestSucess)success failure:(ZQRequestFailure)failure hudInView:(UIView *)view;

/** 文件上传 */
+ (void)upLoadFileWithURL:(NSString *)url params:(NSDictionary *)params filePath:(NSString *)filePath fileName:(NSString *)name mimeType:(NSString *)mimeType success:(ZQRequestSucess)success failed:(ZQRequestFailure)failed;

@end
