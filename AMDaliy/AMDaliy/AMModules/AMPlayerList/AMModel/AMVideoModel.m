//
//  AMVideoModel.m
//  AMDaliy
//
//  Created by 李明明 on 2018/8/6.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import "AMVideoModel.h"

@implementation AMVideoModel

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues
{
    _videoPath = keyedValues[@"videopath"];
    _currenttime = [keyedValues[@"currenttime"] integerValue];
}

+ (id)modelwithDic:(NSDictionary *)dic
{
    
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}


@end
