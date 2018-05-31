//
//  NSFileManager+FileSize.h
//  YiMiApp
//
//  Created by xieyan on 16/4/11.
//  Copyright © 2016年 xieyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (FileSize)

/**
 *  返回绝对路径下文件的大小  (支持文件夹和文件)
 *
 *  @param filePath 文件/文件夹路径
 *
 *  @return 文件大小 单位B
 */
+ (long long)fileSizeOfPath:(NSString*)filePath;

/**
 *  文件大小自动转为个格式化字符串 (如 B->K  B->M B->G)
 *
 *  @param fileSize 文件大小
 */
+ (NSString *)stringWithFileSize:(NSUInteger)fileSize;

@end
