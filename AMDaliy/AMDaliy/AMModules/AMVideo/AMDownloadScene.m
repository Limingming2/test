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
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *urlStr;
    if (self.urlTF.text.length > 0) {
        urlStr = self.urlTF.text;
    }else {
        urlStr = @"https://record-manual.cctalk.com/08d9592535b6fb283dd1523e04eb93c3.mp4?sign=efb350fabcc745fab242a90a7eecbb28&t=5b76c636";
    }
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    NSString *path = [self checkDir:@"lmm"];
    NSString *path =  [AMCreateFile createFileWithPath:videoPath isDir:YES withType:AMDocument];
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
        
        return [NSURL URLWithString:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        NSLog(@"%@", error);
        
    }];
    [task resume];
}

- (NSString *)checkDir:(NSString *)dirName
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:dirName];
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isdir;
    [manager fileExistsAtPath:path isDirectory:&isdir];
    if (!isdir) {
        BOOL reslut = [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        NSLog(@"%d", reslut);
    }
    return path;
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
