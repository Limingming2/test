//
//  AMVideoScene.m
//  AMDaliy
//
//  Created by 李明明 on 2018/8/17.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import "AMVideoScene.h"
#import "AMVideoCell.h"
#import "AMPlayScene.h"


@interface AMVideoScene () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *videos;
@end

@implementation AMVideoScene

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateDatasouce];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:kVideoCellStr];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videos.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:kVideoList2video sender:self.videos[indexPath.row]];
}

#pragma mark - private methods

- (void)updateDatasouce
{
    self.videos = [AMCreateFile filesInDir:kVideoPath withFileType:AMDocument];
    [self.tableView reloadData];
    
}


#pragma mark - user actions

- (IBAction)goDownload:(id)sender
{
    [self performSegueWithIdentifier:@"video2download" sender:nil];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[AMPlayScene class]]) {
        AMPlayScene *scene = (AMPlayScene *)segue.destinationViewController;
        scene.path = sender;
    }
}


@end
