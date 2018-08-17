//
//  AMVideoScene.m
//  AMDaliy
//
//  Created by 李明明 on 2018/8/17.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import "AMVideoScene.h"

@interface AMVideoScene ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end

@implementation AMVideoScene

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -


- (void)updateDatasouce
{
    [[NSFileManager defaultManager] ]
}

- (IBAction)goDownload:(id)sender
{
    [self performSegueWithIdentifier:@"video2download" sender:nil];
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
