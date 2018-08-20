//
//  ZFPlayerControlView+AMControl.m
//  AMDaliy
//
//  Created by 李明明 on 2018/8/20.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import "ZFPlayerControlView+AMControl.h"
#import "AMControlView.h"
#import <objc/runtime.h>

@implementation ZFPlayerControlView (AMControl)

+ (void)load
{
    Method targetShowMethod = class_getInstanceMethod([AMControlView class], NSSelectorFromString(@"am_showControlViewWithAnimated:"));
    Method oriShowMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"showControlViewWithAnimated:"));
    method_exchangeImplementations(targetShowMethod, oriShowMethod);
    
    Method targetHideMethod = class_getInstanceMethod([AMControlView class], NSSelectorFromString(@"am_hideControlViewWithAnimated:"));
    Method oriHideMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"hideControlViewWithAnimated:"));
    method_exchangeImplementations(targetHideMethod, oriHideMethod);
}


@end
