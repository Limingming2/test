//
//  AMVideoView.m
//  AMDaliy
//
//  Created by 李明明 on 2018/8/17.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import "AMVideoCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface AMVideoCell()

@property (nonatomic, weak) IBOutlet UILabel *titleLab;
@property (nonatomic, weak) IBOutlet UIImageView *imgView;

@end

@implementation AMVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadInfo:(NSString *)info
{
    NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:info.lastPathComponent];
    NSString *title = arr.lastObject;
    NSString *imgStr = arr.firstObject;
    self.titleLab.text = title;
    [self.imgView setImageWithURL:[NSURL URLWithString:imgStr]];
}

@end
