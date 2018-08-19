//
//  AMPlayScene.m
//  AMDaliy
//
//  Created by 李明明 on 2018/8/17.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import "AMPlayScene.h"
#import "AMControlView.h"
#import <ZFPlayer/ZFPlayer.h>
#import <ZFAVPlayerManager.h>
#import <ZFPlayerControlView.h>
#import <ZFIJKPlayerManager.h>

@interface AMPlayScene ()
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, weak) IBOutlet UIImageView *playerView;
@end

@implementation AMPlayScene

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self startPlayWith:self.path];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - private methods

- (void)startPlayWith:(NSString *)path
{
//    ZFAVPlayerManager *manager = [[ZFAVPlayerManager alloc] init];
    ZFIJKPlayerManager *manager = [[ZFIJKPlayerManager alloc] init];
    self.player = [ZFPlayerController playerWithPlayerManager:manager containerView:self.playerView];
    AMControlView *controlView = [[AMControlView alloc] init];
    self.player.controlView = controlView;
    manager.assetURL = [NSURL fileURLWithPath:path];
    [controlView setRate:^(CGFloat rate) {
        manager.rate = rate;
    }];
}

#pragma mark - setter and getter

- (void)setPath:(NSString *)path
{
    _path = path;
}

- (BOOL)shouldAutorotate
{
    return YES;
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
