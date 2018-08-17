//
//  AMCreateFile.m
//  AMDaliy
//
//  Created by 李明明 on 2018/8/8.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import "AMCreateFile.h"

static AMCreateFile *_fileControl;

@interface AMCreateFile ()
@property (nonatomic, assign) AMSandbox fileType;
@end

@implementation AMCreateFile

- (instancetype)init
{
    self = [super init];
    if (self) {
        _fileControl = self;
    }
    return self;
}

+ (NSString *)createFileWithPath:(NSString *)path isDir:(BOOL)dir withType:(AMSandbox)fileType
{
    NSFileManager *filemanager = [NSFileManager defaultManager];
    NSSearchPathDirectory type = (NSSearchPathDirectory)fileType;
    NSString *currentPath = [NSSearchPathForDirectoriesInDomains(type, NSUserDomainMask, YES) lastObject];
    NSString *resultPath = [currentPath stringByAppendingPathComponent:path];
    BOOL isdir;
    BOOL isfile = [filemanager fileExistsAtPath:resultPath isDirectory:&isdir];
    BOOL success = YES;
    NSError *error;
    if (dir) {
        if (!isdir)
        {
            success = [filemanager createDirectoryAtPath:resultPath
                             withIntermediateDirectories:YES
                                              attributes:nil
                                                   error:&error];
        }else
        {
        }
    }else {
        if (!isfile)
        {
            NSString *tmp = [resultPath stringByDeletingLastPathComponent];
            isfile = [filemanager fileExistsAtPath:tmp isDirectory:&isdir];
            if (!isdir) {
                [filemanager createDirectoryAtPath:tmp withIntermediateDirectories:YES attributes:nil error:&error];
            }
            success = [filemanager createFileAtPath:resultPath
                                           contents:nil
                                         attributes:nil];
        }else
        {
        }
    }
    if (!success) {
        resultPath = @"";
        NSLog(@"创建失败：%@", error);
    }
    return resultPath;
    
}

+ (NSFileManager *)filemanager
{
    return [NSFileManager defaultManager];
}

+ (BOOL)fileExist:(NSString *)path
{
    return [self.filemanager fileExistsAtPath:path];
}


















@end
