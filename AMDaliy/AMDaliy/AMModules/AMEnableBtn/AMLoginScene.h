//
//  AMLoginScene.h
//  AMDaliy
//
//  Created by 李明明 on 2018/3/23.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AMReceiveDelegate <NSObject>

@property (nonatomic, strong) NSMutableArray *arr;

@end



@interface AMLoginScene : UIViewController

@property (nonatomic, assign) id<AMReceiveDelegate> delegate;
@end
