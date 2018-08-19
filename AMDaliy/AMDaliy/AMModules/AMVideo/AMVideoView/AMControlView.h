//
//  AMControlView.h
//  AMDaliy
//
//  Created by 李明明 on 2018/8/19.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import <ZFPlayer/ZFPlayer.h>
#import <ZFPlayer/ZFPlayerControlView.h>

@interface AMControlView : ZFPlayerControlView

@property (nonatomic, copy) void(^rate)(CGFloat rate);

@end
