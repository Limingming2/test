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

+ (void)createFileWithPath:(NSString *)path withType:(AMSandbox)fileType
{
    NSFileManager *filemanager = [NSFileManager defaultManager];
    
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory directory, NSUserDomainMask, YES)]
    
}

@end
