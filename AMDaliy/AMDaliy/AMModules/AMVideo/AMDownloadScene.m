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
    NSURLSessionConfiguration *config = [[NSURLSessionConfiguration alloc] init];
    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    NSURL *url = [NSURL URLWithString:self.urlTF.text];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *path = [self checkDir:@"lmm"];
    NSString *filePath = [path stringByAppendingPathComponent:url.lastPathComponent];
    NSURLSessionDownloadTask *task = [sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [NSURL URLWithString:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
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
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
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
