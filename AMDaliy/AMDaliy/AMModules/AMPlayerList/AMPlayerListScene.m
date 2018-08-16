//
//  AMPlayerListScene.m
//  AMDaliy
//
//  Created by 李明明 on 2018/8/3.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import "AMPlayerListScene.h"
#import <ZFPlayer/ZFPlayer.h>
#import <ZFAVPlayerManager.h>
#import <ZFPlayerControlView.h>
#import "AMPlayerCell.h"
#import "AMVideoModel.h"

@interface AMPlayerListScene ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) NSMutableArray *arr;
@end

@implementation AMPlayerListScene

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tag = 1000;
    
    NSArray *tmpArr = [self dataSource];
    self.arr = [@[] mutableCopy];
    for (NSDictionary *tmpdic in tmpArr) {
        AMVideoModel *model = [AMVideoModel modelwithDic:tmpdic];
        NSLog(@"%@", model);
        [self.arr addObject:model];
    }
    
    [self makePlayer];
    
}

- (void)makePlayer
{
    ZFAVPlayerManager *manager = [[ZFAVPlayerManager alloc] init];
    self.player = [ZFPlayerController playerWithScrollView:self.tableView playerManager:manager containerViewTag:self.tag];
    ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
    self.player.controlView = controlView;
    self.player.assetURLs = extracted();
    [self.tableView reloadData];
//    @weakify(self)
//    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
//        @strongify(self)
//        if (self.player.playingIndexPath.row < self.player.assetURLs.count - 1 && !self.player.isFullScreen) {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.player.playingIndexPath.row+1 inSection:0];
////            [self playTheVideoAtIndexPath:indexPath scrollToTop:YES];
//        } else if (self.player.isFullScreen) {
//            [self.player stopCurrentPlayingCell];
//        }
//    };
    [self playTheNext:[NSIndexPath indexPathForRow:0 inSection:0]];
    @weakify(self);
    [self.player setPlayerDidToEnd:^(id<ZFPlayerMediaPlayback>  _Nonnull asset) {
        @strongify(self);
//        NSIndexPath *indexPath =
        if (self.player.playingIndexPath.row < self.arr.count - 1) {
            [self playTheNext:[NSIndexPath indexPathForRow:self.player.playingIndexPath.row + 1 inSection:self.player.playingIndexPath.section]];
        }
    }];
}


- (void)playTheNext:(NSIndexPath *)indexPath
{
    
    [self.player playTheIndexPath:indexPath scrollToTop:YES completionHandler:^{
        

        
    }];
    
}

- (BOOL)shouldAutorotate
{
    return self.player.shouldAutorotate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMPlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"playerreusestr"];
    [cell loadInfo:indexPath withModel:self.arr[indexPath.row]] ;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 218;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

static NSArray * extracted() {
    return @[[NSURL URLWithString:@"https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4"],
             [NSURL URLWithString:@"https://www.apple.com/105/media/cn/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/bruce/mac-bruce-tpl-cn-2018_1280x720h.mp4"],
             [NSURL URLWithString:@"https://www.apple.com/105/media/us/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/peter/mac-peter-tpl-cc-us-2018_1280x720h.mp4"],
             [NSURL URLWithString:@"https://www.apple.com/105/media/us/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/grimes/mac-grimes-tpl-cc-us-2018_1280x720h.mp4"],
             [NSURL URLWithString:@"http://flv3.bn.netease.com/tvmrepo/2018/6/H/9/EDJTRBEH9/SD/EDJTRBEH9-mobile.mp4"],
             [NSURL URLWithString:@"http://flv3.bn.netease.com/tvmrepo/2018/6/9/R/EDJTRAD9R/SD/EDJTRAD9R-mobile.mp4"],
             [NSURL URLWithString:@"http://dlhls.cdn.zhanqi.tv/zqlive/34338_PVMT5.m3u8"],
             [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-video/7_517c8948b166655ad5cfb563cc7fbd8e.mp4"],
             [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/68_20df3a646ab5357464cd819ea987763a.mp4"],
             [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/118_570ed13707b2ccee1057099185b115bf.mp4"],
             [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/15_ad895ac5fb21e5e7655556abee3775f8.mp4"],
             [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/12_cc75b3fb04b8a23546d62e3f56619e85.mp4"],
             [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-smallvideo/5_6d3243c354755b781f6cc80f60756ee5.mp4"],
             [NSURL URLWithString:@"http://tb-video.bdstatic.com/tieba-movideo/11233547_ac127ce9e993877dce0eebceaa04d6c2_593d93a619b0.mp4"]];
}

- (NSArray *)dataSource
{
    NSArray *arr = @[
  @{@"videopath":@"https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4",@"currenttime":@"0"},
  @{@"videopath":@"https://www.apple.com/105/media/cn/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/bruce/mac-bruce-tpl-cn-2018_1280x720h.mp4",@"currenttime":@"0"},
  @{@"videopath":@"https://www.apple.com/105/media/us/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/peter/mac-peter-tpl-cc-us-2018_1280x720h.mp4",@"currenttime":@"0"},
  @{@"videopath":@"https://www.apple.com/105/media/us/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/grimes/mac-grimes-tpl-cc-us-2018_1280x720h.mp4",@"currenttime":@"0"},
  @{@"videopath":@"http://flv3.bn.netease.com/tvmrepo/2018/6/H/9/EDJTRBEH9/SD/EDJTRBEH9-mobile.mp4",@"currenttime":@"0"},
  @{@"videopath":@"http://flv3.bn.netease.com/tvmrepo/2018/6/9/R/EDJTRAD9R/SD/EDJTRAD9R-mobile.mp4",@"currenttime":@"0"},
  @{@"videopath":@"http://dlhls.cdn.zhanqi.tv/zqlive/34338_PVMT5.m3u8",@"currenttime":@"0"},
  @{@"videopath":@"http://tb-video.bdstatic.com/tieba-video/7_517c8948b166655ad5cfb563cc7fbd8e.mp4",@"currenttime":@"0"},
  @{@"videopath":@"http://tb-video.bdstatic.com/tieba-smallvideo/68_20df3a646ab5357464cd819ea987763a.mp4",@"currenttime":@"0"},
  @{@"videopath":@"http://tb-video.bdstatic.com/tieba-smallvideo/118_570ed13707b2ccee1057099185b115bf.mp4",@"currenttime":@"0"},
  @{@"videopath":@"http://tb-video.bdstatic.com/tieba-smallvideo/15_ad895ac5fb21e5e7655556abee3775f8.mp4",@"currenttime":@"0"},
  @{@"videopath":@"http://tb-video.bdstatic.com/tieba-smallvideo/12_cc75b3fb04b8a23546d62e3f56619e85.mp4",@"currenttime":@"0"},
  @{@"videopath":@"http://tb-video.bdstatic.com/tieba-smallvideo/5_6d3243c354755b781f6cc80f60756ee5.mp4",@"currenttime":@"0"},
  @{@"videopath":@"http://tb-video.bdstatic.com/tieba-movideo/11233547_ac127ce9e993877dce0eebceaa04d6c2_593d93a619b0.mp4",@"currenttime":@"0"}];
    return arr;

}

@end
