//
//  AMDownloadScene.m
//  AMDaliy
//
//  Created by 李明明 on 2018/8/17.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import "AMDownloadScene.h"
#import <AFNetworking/AFNetworking.h>

@interface AMDownloadScene ()
@property (nonatomic, weak) IBOutlet UIButton *downloadBtn;
@property (nonatomic, weak) IBOutlet UITextField *urlTF;
@property (nonatomic, weak) IBOutlet UILabel *progressLab;
@end

@implementation AMDownloadScene

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)downloadAction:(id)sender
{
    NSString *urlStr;
    if (self.urlTF.text.length > 0) {
        urlStr = self.urlTF.text;
    }else {
        urlStr = @"https://record-manual.cctalk.com/5f849fe7871b9e8284c4db9b602798c0.mp4?sign=1bb4ff45337ae6c0e0983e22b45333eb&t=5b780d4c";
        [HToastView toast:@"请输入地址，现在是默认视频地址"];
    }
    [self downActionWithPath:urlStr];
}

- (void)downActionWithPath:(NSString *)str
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURL *url = [NSURL URLWithString:str];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *path = [AMCreateFile createFileWithPath:kVideoPath isDir:YES withType:AMDocument];
    NSString *filePath = [path stringByAppendingPathComponent:url.lastPathComponent];
    if ([AMCreateFile fileExist:filePath]) {
        return;
    }
    NSURLSessionDownloadTask *task = [sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            CGFloat progress = (CGFloat)downloadProgress.completedUnitCount / (CGFloat)downloadProgress.totalUnitCount;
            self.progressLab.text = [NSString stringWithFormat:@"%.2f%%", progress * 100];
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"%@", error);
        if (!error) {
            [HToastView toast:@"下载成功!"];
        }else {
            [HToastView toast:[NSString stringWithFormat:@"错误信息：%@", error.userInfo[NSLocalizedDescriptionKey]]];
        }
    }];
    [task resume];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
