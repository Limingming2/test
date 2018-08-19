//
//  AMDownloadScene.m
//  AMDaliy
//
//  Created by 李明明 on 2018/8/17.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import "AMDownloadScene.h"
#import <AFNetworking/AFNetworking.h>
#import "AMRequestManager.h"

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

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

// 点击下载，整理下载链接
- (IBAction)downloadAction:(id)sender
{
    NSString *urlStr;
    if (self.urlTF.text.length > 0) {
        urlStr = self.urlTF.text;
    }else {
//        urlStr = @"https://record-manual.cctalk.com/5f849fe7871b9e8284c4db9b602798c0.mp4?sign=1bb4ff45337ae6c0e0983e22b45333eb&t=5b780d4c";
        [HToastView toast:@"请输入地址"];
        return ;
    }
    [AMRequestManager sendRequest:urlStr success:^(NSDictionary *dic) {
        [self downActionWithPath:dic];
    } fail:^(NSError *error) {
        NSLog(@"error:%@", error);
        [HToastView toast:error.userInfo[NSLocalizedDescriptionKey]];
    }];
}

// 执行下载
- (void)downActionWithPath:(NSDictionary *)result
{
    NSString *str = result[kVideoUrlKey];
    [AMRequestManager downloadVideo:str progress:^(CGFloat progress) {
        self.progressLab.text = [NSString stringWithFormat:@"%.2f%%", progress];
    } success:^(NSDictionary *dic) {
        [HToastView toast:dic[kMessageKey]];
        [self saveInfo:@[result[kCoverUrlKey], result[kVideoNameKey]] withKey:str];
    } fail:^(NSError *error) {
        [HToastView toast:[NSString stringWithFormat:@"错误信息：%@", error.userInfo[NSLocalizedDescriptionKey]]];
    }];
}

- (void)saveInfo:(NSArray *)info withKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:info forKey:[NSURL URLWithString:key].lastPathComponent];
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
