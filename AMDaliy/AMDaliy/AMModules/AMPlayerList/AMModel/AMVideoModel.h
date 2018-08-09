//
//  AMVideoModel.h
//  AMDaliy
//
//  Created by 李明明 on 2018/8/6.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMVideoModel : NSObject
@property (nonatomic, strong) NSString *videoPath;
@property (nonatomic, assign) NSInteger currenttime;

+ (id)modelwithDic:(NSDictionary *)dic;

@end
