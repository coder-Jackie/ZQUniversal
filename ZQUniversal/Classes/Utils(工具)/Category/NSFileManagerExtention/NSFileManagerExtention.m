//
//  NSFileManager+FileSize.m
//  YiMiApp
//
//  Created by xieyan on 16/4/11.
//  Copyright © 2016年 xieyan. All rights reserved.
//

#import "NSFileManagerExtention.h"

@implementation NSFileManager (FileSize)

// 返回绝对路径下文件的大小  (支持文件夹和文件)
+ (long long)fileSizeOfPath:(NSString*)filePath
{
    // 1.文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 2.判断file是否存在
    BOOL isDirectory = NO;
    BOOL fileExists = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
    // 文件\文件夹不存在
    if (fileExists == NO) return 0;
    
    // 3.判断file是否为文件夹
    if (isDirectory) { // 是文件夹
        NSArray *subpaths = [mgr contentsOfDirectoryAtPath:filePath error:nil];
        long long totalSize = 0;
        for (NSString *subpath in subpaths) {
            NSString *fullSubpath = [filePath stringByAppendingPathComponent:subpath];
            totalSize += [self fileSizeOfPath:fullSubpath];
        }
        return totalSize;
    } else { // 不是文件夹, 文件
        // 直接计算当前文件的尺寸
        NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
        return [attr[NSFileSize] longLongValue];
    }
}


// 文件大小自动转为个格式化字符串 (如 B->K  B->M B->G)
+ (NSString *)stringWithFileSize:(NSUInteger)fileSize {
    
    NSString *sizeStr;
    if (fileSize < 1024) {
        sizeStr = [NSString stringWithFormat:@"%lu B", (unsigned long)fileSize];
    } else if (fileSize >= 1024 && fileSize < 1024 * 1024) {
        sizeStr = [NSString stringWithFormat:@"%.2f KB", fileSize / 1024.0];
    } else if (fileSize >= 1024 * 1024 && fileSize < 1024 * 1024 * 1024) {
        sizeStr = [NSString stringWithFormat:@"%.2f MB", fileSize / (1024 * 1024.0)];
    } else {
        sizeStr = [NSString stringWithFormat:@"%.2f GB", fileSize / (1024 * 1024 * 1024.0)];
    }
    return sizeStr;
}


+(void)removePath:(NSString*)path{
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}
@end

@implementation NSFileManager (path)

+(void)checkPath:(NSString*)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if(!(isDirExist && isDir))
    {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if(!bCreateDir){
            NSLog(@"Create Audio Directory Failed.");
        }
        NSLog(@"%s %@",__func__,path);
    }
}

@end
