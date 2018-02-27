//
//  AMWaterFlowLayout.m
//  AMDaliy
//
//  Created by limingming on 2018/2/26.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import "AMWaterFlowLayout.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kItemWidth  90
#define kItemHeight  45
#define kLineMargin  10

@interface AMWaterFlowLayout ()<UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableArray *attris;
@end

@implementation AMWaterFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(kScreenWidth, (kItemHeight + kLineMargin) * 2 * ceil((CGFloat)self.dataArr.count / 5));
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kItemWidth, kItemHeight);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    self.attris = [@[] mutableCopy];
    for (NSInteger i = 0; i < self.dataArr.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attri = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attris addObject:attri];
    }
    return self.attris;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSInteger row = indexPath.row;
    CGFloat upMargin = (kScreenWidth - kItemWidth * 3) / 4; // 上面一行的间隙
    CGFloat downMargin = (kScreenWidth - kItemWidth * 2) / 3; // 下面一行的间隙
    NSInteger index = row % 5;
    CGFloat x = index < 3 ? upMargin + index * (upMargin + kItemWidth) : downMargin + (index - 3) * (downMargin + kItemWidth);
    NSInteger section = row / 5;
    CGFloat y = index < 3 ?
    kLineMargin + (kItemHeight * 2 + kLineMargin * 2) * section :
    kLineMargin + (kItemHeight * 2 + kLineMargin * 2) * section + kLineMargin + kItemHeight;
    attri.frame = CGRectMake(x, y, kItemWidth, kItemHeight);
    return attri;
}

@end
