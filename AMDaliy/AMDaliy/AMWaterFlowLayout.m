//
//  AMWaterFlowLayout.m
//  AMDaliy
//
//  Created by limingming on 2018/2/26.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import "AMWaterFlowLayout.h"

@interface AMWaterFlowLayout ()<UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableArray *attris;
@end

@implementation AMWaterFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(90, 45);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    for (NSInteger i = 0; i < self.dataArr.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attri = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attris addObject:attri];
    }
    return self.attris;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attri = [[UICollectionViewLayoutAttributes alloc] init];
    NSInteger row = indexPath.row;
//    CGFloat x =
//    attri.frame =
    return attri;
}

@end
