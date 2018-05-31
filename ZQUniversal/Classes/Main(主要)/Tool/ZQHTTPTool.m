//
//  ZQHTTPTool.m
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/18.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import "ZQHTTPTool.h"
#import <AFNetworking.h>


@implementation ZQHTTPTool

+ (void)GET:(NSString *)url params:(NSDictionary *)params success:(ZQRequestSucess)success failure:(ZQRequestFailure)failure
{
    [self GET:url params:params success:success failure:failure hudInView:nil];
}


+ (void)GET:(NSString *)url params:(NSDictionary *)params success:(ZQRequestSucess)success failure:(ZQRequestFailure)failure hudInView:(UIView *)view
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/json",@"text/javascript",@"application/x-javascript",@"text/plain",nil];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (view) {
        [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (view) {
            [MBProgressHUD hideHUDForView:view animated:YES];
        }
        int code = [responseObject[@"code"] intValue];
        !success ? : success(responseObject,code);
        ZQLog(@"\n接口:\n%@入参:\n%@出参:\n%@",url,params,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (view) {
            [MBProgressHUD hideHUDForView:view animated:YES];
        }
        
        !failure ? : failure(error);
        ZQLog(@"\n接口:\n%@入参:\n%@出参:\n%@",url,params,error);
    }];
}

+ (void)POST:(NSString *)url params:(NSDictionary *)params success:(ZQRequestSucess)success failure:(ZQRequestFailure)failure
{
    [self POST:url params:params success:success failure:false hudInView:nil];
}


+ (void)POST:(NSString *)url params:(NSDictionary *)params success:(ZQRequestSucess)success failure:(ZQRequestFailure)failure hudInView:(UIView *)view
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/json",@"text/javascript",@"application/x-javascript",@"text/plain",nil];
    
    if (view) {
        [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (view) {
            [MBProgressHUD hideHUDForView:view animated:YES];
        }
        
        int code = [responseObject[@"code"] intValue];
        !success ? : success(responseObject,code);
        ZQLog(@"\n接口:\n%@入参:\n%@出参:\n%@",url,params,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (view) {
            [MBProgressHUD hideHUDForView:view animated:YES];
        }
        
        !failure ? : failure(error);
        ZQLog(@"\n接口:\n%@入参:\n%@出参:\n%@",url,params,error);
    }];
    
}


+ (void)upLoadFileWithURL:(NSString *)url params:(NSDictionary *)params filePath:(NSString *)filePath fileName:(NSString *)name mimeType:(NSString *)mimeType success:(ZQRequestSucess)success failed:(ZQRequestFailure)failed
{
    //AFN3.0+基于封住HTPPSession的句柄
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:filePath]];
        
        // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
        // 要解决此问题，
        // 可以在上传时使用当前的系统事件作为文件名
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@/%@", str,name];
        
        //上传
        /*
         此方法参数
         1. 要上传的[二进制数据]
         2. 对应网站上[upload.php中]处理文件的[字段"file"]
         3. 要保存在服务器上的[文件名]
         4. 上传文件的[mimeType]
         */
        if ([NSString isBlank:mimeType]) {
            [formData appendPartWithFormData:data name:@"multipartFile"];
        }else {
            [formData appendPartWithFileData:data name:@"multipartFile" fileName:fileName mimeType:mimeType];//txt
        }
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //上传进度
        NSLog(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        // 回到主队列刷新UI,用户自定义的进度条
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传成功 %@", responseObject);
        !success ? : success(responseObject,[responseObject[@"code"] intValue]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败 %@", error);
        !failed ? : failed(error);
        
    }];
    
    
}

@end
