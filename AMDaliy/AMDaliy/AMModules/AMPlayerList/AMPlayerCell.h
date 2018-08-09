//
//  AMPlayerCell.h
//  AMDaliy
//
//  Created by 李明明 on 2018/8/3.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMVideoModel.h"

@interface AMPlayerCell : UITableViewCell

- (void)loadInfo:(NSIndexPath *)indexPath withModel:(AMVideoModel *)model;

@end
