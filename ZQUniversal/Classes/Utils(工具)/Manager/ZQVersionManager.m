//
//  ZQVersionManager.m
//  ZQUniversal
//
//  Created by CoderZQ on 2018/5/29.
//  Copyright © 2018年 CoderZQ. All rights reserved.
//

#import "ZQVersionManager.h"

@interface ZQVersionManager() <UIAlertViewDelegate>

@end


@implementation ZQVersionManager

+ (void)checkVersionURL:(NSString *)url param:(NSDictionary *)param
{
    [ZQHTTPTool POST:url params:param success:^(id response, int code) {
        if (code == 200) {
            ZQLog(@"更新接口信息:%@",response);
            NSDictionary *dict= response[@"data"];
            if (![dict isKindOfClass:[NSDictionary class]]) {
                return;
            }
            NSString *title = dict[@"title"];
            title = @"";// 更新不显示title
            NSString *version = [NSString stringWithFormat:@"%@",dict[@"versionCode"]];
            NSString *description = dict[@"description"];
            NSString *isForce = [NSString stringWithFormat:@"%@",dict[@"isForce"]];
            
            
            [kUserDefaults setObject:[dict objectForKey:@"downloadUrl"] forKey:@"url"];
            [kUserDefaults synchronize];
            
            int ver = [version intValue];
            NSString* build = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
            
            if (ver > [build integerValue]) {
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前有最新版本,确定更新?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alertView show];
                
                //                [[SKVersionView loadVersionView]updateIsForce:[isForce isEqualToString:@"1"]?YES:NO content:description update:^{
                //
                //                    [self openUpdate:[dict objectForKey:@"downloadUrl"]];
                //                    [VersionManager exitAPPType:type];
                //
                //                }];
                
                
            }
        }
    } failure:^(NSError *error) {
        ZQLog(@"更新失败:%@",error);
    }];
    
    
}


+ (BOOL)isNewVersionURL:(NSString *)url param:(NSDictionary *)param
{
    __block BOOL isNew = NO;
    [ZQHTTPTool POST:url params:param success:^(id response, int code) {
        if (code == 200) {
            ZQLog(@"更新接口信息:%@",response);
            NSDictionary *dict= response[@"data"];
            if (![dict isKindOfClass:[NSDictionary class]]) {
                return;
            }
            NSString *title = dict[@"title"];
            title = @"";// 更新不显示title
            NSString *version = [NSString stringWithFormat:@"%@",dict[@"versionCode"]];
            NSString *description = dict[@"description"];
            NSString *isForce = [NSString stringWithFormat:@"%@",dict[@"isForce"]];
            
            
            [kUserDefaults setObject:[dict objectForKey:@"downloadUrl"] forKey:@"url"];
            [kUserDefaults synchronize];
            
            int ver = [version intValue];
            NSString* build = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
            
            // 服务器版本大于当前本地版本 说明当前不是最新版本
            if (ver > [build integerValue]) {
                
                isNew = NO;
            } else { // 当前是最新版本
                isNew = YES;
            }
        }
    } failure:^(NSError *error) {
        ZQLog(@"更新失败:%@",error);
    }];
    
    return isNew;
    
}
     
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {  // 点击了取消按钮
        return;
    } else {  // 点击了确定按钮,清理缓存
        NSString *url = [kUserDefaults objectForKey:@"url"];
        [self openUpdate:url];
    }
    
}


- (void)openUpdate:(NSString *)url{
    // 对于url中包含非标准url的字符对其进行编码
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
@end
