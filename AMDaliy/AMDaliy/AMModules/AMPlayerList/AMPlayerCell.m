//
//  AMPlayerCell.m
//  AMDaliy
//
//  Created by 李明明 on 2018/8/3.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import "AMPlayerCell.h"
#import "UIImageView+AMImageView.h"

@interface AMPlayerCell ()

@property (nonatomic, weak) IBOutlet UIImageView *imgView;
@property (nonatomic, weak) IBOutlet UIButton *btn;

@end

@implementation AMPlayerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadInfo:(NSIndexPath *)indexPath withModel:(AMVideoModel *)model
{
    self.imgView.tag = indexPath.row + 1000;
    [self.imageView am_setImageWithVideoPath:model.videoPath];
}

@end
