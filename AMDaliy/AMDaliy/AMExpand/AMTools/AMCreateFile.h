//
//  AMCreateFile.h
//  AMDaliy
//
//  Created by 李明明 on 2018/8/8.
//  Copyright © 2018年 limingming. All rights reserved.
//



#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    AMDocument = NSDocumentDirectory,
    AMLibrary = NSLibraryDirectory,
    AMTemp = nstmpdirec,
} AMSandbox;


@interface AMCreateFile : NSObject

/**
 创建文件/目录

 @param path 目录
 @param fileType 存储位置
 */
+ (void)createFileWithPath:(NSString *)path withType:(AMSandbox)fileType;

@end
