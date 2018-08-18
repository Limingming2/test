//
//  AMRequestManager.h
//  AMDaliy
//
//  Created by 李明明 on 2018/8/18.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Success)(NSDictionary *dic);
typedef void(^Failure)(NSError *error);


@interface AMRequestManager : NSObject

@property (nonatomic, strong) NSMutableArray *downloadings;

/**
 下载

 @param urlStr 下载地址
 @param progress 进度回调
 @param success 成功回调
 @param fail 失败回调
 @return 返回任务
 */
+ (NSURLSessionDownloadTask *)downloadVideo:(NSString *)urlStr progress:(void(^)(CGFloat))progress success:(Success)success fail:(Failure)fail;


/**
 请求接口

 @param urlStr 接口链接
 @param success 成功回调
 @param fail 失败回调
 @return 返回任务
 */
+ (NSURLSessionDataTask *)sendRequest:(NSString *)urlStr success:(Success)success fail:(Failure)fail;

@end
