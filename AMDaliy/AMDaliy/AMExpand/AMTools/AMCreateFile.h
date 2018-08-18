//
//  AMCreateFile.h
//  AMDaliy
//
//  Created by 李明明 on 2018/8/8.
//  Copyright © 2018年 limingming. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <Foundation/NSString.h>
#import <Foundation/NSArray.h>

typedef enum : NSUInteger {
    AMDocument = NSDocumentDirectory,
    AMLibrary = NSLibraryDirectory,
    AMTemp = NSCachesDirectory,
} AMSandbox;


@interface AMCreateFile : NSObject

/**
 创建文件/目录

 @param path 目录
 @param dir 是否是目录
 @param fileType 存储位置
 @return 返回路径
 */
+ (NSString *)createFileWithPath:(NSString *)path isDir:(BOOL)dir withType:(AMSandbox)fileType;


/**
 判断文件是否存在

 @param path 文件路径
 @return 是否存在
 */
+ (BOOL)fileExist:(NSString *)path;


/**
 获取文件夹下文件数组

 @param path 文件夹路径
 @return 返回文件数组
 */
+ (NSArray *)filesInDir:(NSString *)path withFileType:(AMSandbox)fileType;

+ (void)deleteFileWith:(NSString *)path;

@end
