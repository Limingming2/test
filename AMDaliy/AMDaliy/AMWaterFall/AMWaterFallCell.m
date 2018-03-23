//
//  AMWaterFallCell.m
//  AMDaliy
//
//  Created by limingming on 2018/2/26.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import "AMWaterFallCell.h"

@interface AMWaterFallCell ()

@property (nonatomic, weak) IBOutlet UILabel *titleLab;

@end

@implementation AMWaterFallCell
@synthesize selected = _selected;

- (void)loadInfo:(id)info
{
    self.titleLab.text = info;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    if (selected) {
        self.titleLab.textColor = [UIColor whiteColor];
        self.titleLab.backgroundColor = [UIColor blueColor];
    }else {
        self.titleLab.textColor = [UIColor blackColor];
        self.titleLab.backgroundColor = [UIColor lightGrayColor];
    }
    
   
}

@end
