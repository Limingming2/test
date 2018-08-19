//
//  AMRequestManager.m
//  AMDaliy
//
//  Created by 李明明 on 2018/8/18.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import "AMRequestManager.h"
#import <AFNetworking/AFNetworking.h>

static AMRequestManager *_manager;

@implementation AMRequestManager

+ (AMRequestManager *)singleInstanse
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
        _manager.downloadings = [NSMutableArray array];
    });
    return _manager;
}

+ (AFURLSessionManager *)configSessionWithJson:(BOOL)isJson
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    if (isJson) {
        sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }else {
        sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return sessionManager;
}

+ (NSURLSessionDownloadTask *)downloadVideo:(NSString *)urlStr progress:(void(^)(CGFloat))progress success:(Success)success fail:(Failure)fail
{
    AFURLSessionManager *sessionManager = [self configSessionWithJson:NO];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *path = [AMCreateFile createFileWithPath:kVideoPath isDir:YES withType:AMDocument];
    NSString *filePath = [path stringByAppendingPathComponent:url.lastPathComponent];
    if ([AMCreateFile fileExist:filePath] ||
        [[self singleInstanse].downloadings containsObject:url.lastPathComponent]) {
        return nil;
    }
    [[self singleInstanse].downloadings addObject:url.lastPathComponent];
    NSURLSessionDownloadTask *task = [sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            CGFloat value = (CGFloat)downloadProgress.completedUnitCount / (CGFloat)downloadProgress.totalUnitCount;
            progress(value * 100);
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (!error) {
            success(@{@"message":@"下载成功"});
        }else {
            fail(error);
        }
        [[self singleInstanse].downloadings removeObject:urlStr];
    }];
    [task resume];
    return task;
}

+ (NSURLSessionDataTask *)sendRequest:(NSString *)urlStr success:(Success)success fail:(Failure)fail
{
    AFURLSessionManager *sessionManager = [self configSessionWithJson:YES];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLSessionDataTask *task = [sessionManager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *result = (NSDictionary *)responseObject;
            if ([result[kStatusKey] integerValue] == 0) {
                success(result[kDataKey]);
            }else {
                NSError *userError = [NSError
                                      errorWithDomain:@"com.self.define.error"
                                      code:[result[kStatusKey] integerValue]
                                      userInfo:@{NSLocalizedDescriptionKey: result[kMessageKey]}];
                fail(userError);
            }
        }else {
            fail(error);
        }
    }];
    [task resume];
    return task;
}






@end
