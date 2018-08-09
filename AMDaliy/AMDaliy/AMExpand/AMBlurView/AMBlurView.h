//
//  AMBlurView.h
//  AMDaliy
//
//  Created by 李明明 on 2018/8/6.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 高斯模糊
 */
@interface AMBlurView : UIImageView

+ (void)showInWindow:(UIWindow *)window;

+ (void)dismiss;

@end
