//
//  AMWaterFallScene.m
//  AMDaliy
//
//  Created by limingming on 2018/2/26.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import "AMWaterFallScene.h"
#import "AMWaterFallCell.h"
#import "AMWaterFlowLayout.h"

static NSString *const kItemReuse = @"ItemReuse";

@interface AMWaterFallScene ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSMutableArray *selectedArr;
@end

@implementation AMWaterFallScene

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = @[@"a", @"b",@"c",@"d",@"e",@"f", @"g",@"h",@"i",@"j",@"k", @"l",@"m",@"n",@"o",@"p", @"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z"];
    AMWaterFlowLayout *layout = [[AMWaterFlowLayout alloc] init];
    layout.dataArr = self.dataArr;
    self.collectionView.collectionViewLayout = layout;
    // 多选YES 单选NO	
    self.collectionView.allowsMultipleSelection = YES;
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"打印" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    self.selectedArr = [@[] mutableCopy];
}

- (void)rightAction:(id)sender
{
    NSLog(@"%@", self.selectedArr);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AMWaterFallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kItemReuse forIndexPath:indexPath];
    [cell loadInfo:self.dataArr[indexPath.item]];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.selectedArr addObject:self.dataArr[indexPath.item]];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.selectedArr removeObject:self.dataArr[indexPath.item]];
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
