//
//  AMDailyScene.m
//  AMDaliy
//
//  Created by limingming on 2019/1/4.
//  Copyright © 2019年 limingming. All rights reserved.
//

#import "AMDailyScene.h"
#import <math.h>
@interface AMDailyScene ()

@end

@implementation AMDailyScene

- (void)viewDidLoad {
    [super viewDidLoad];
    NSTimeInterval start = [NSDate date].timeIntervalSince1970;
//    NSInteger result = [self calculStepsWaysBy:5];
//    NSLog(@"%zd %.3f", result, ([NSDate date].timeIntervalSince1970 - start) * 1000);
//    result = [self calculAnd:2147483646 to:2147483647];
    NSArray *result = [self topKFrequent:@[@1,@1,@1,@2,@2,@3] k:2];
    NSLog(@"%@ %.3f", result, ([NSDate date].timeIntervalSince1970 - start) * 1000);
    
    
}



/**
 假设你正在爬楼梯。需要 n 阶你才能到达楼顶。
 每次你可以爬 1 或 2 个台阶。你有多少种不同的方法可以爬到楼顶呢？
 注意：给定 n 是一个正整数。

 @param totalSteps 台阶数
 @return 返回方法数
 */
- (NSInteger)calculStepsWaysBy:(NSInteger)totalSteps
{
    NSInteger result = 0;
    
    if (totalSteps == 0) {
        result = 0;
    }else if (totalSteps == 1) {
        result = 1;
    }else if (totalSteps == 2) {
        result = 2;
    }else {
        NSInteger a = 1;
        NSInteger b = 2;
        for (NSInteger i = 3; i <= totalSteps; i++) {
            result = a + b;
            a = b;
            b = result;
        }
    }
    return result;
}



/**
 给定范围 [m, n]，其中 0 <= m <= n <= 2147483647，返回此范围内所有数字的按位与（包含 m, n 两端点）。

 @param m 起始值
 @param n 结束值
 @return  返回结果
 */
- (int)calculAnd:(int)m to:(int)n
{
    int result = m;
    for (int i = m + 1; i <= n && i >= 0; i++) {
        if (result == 0) {
            break;
        }
        result = result & i;
    }
    return result;
}



/**
 给定一个非空的整数数组，返回其中出现频率前 k 高的元素。

 @param nums 数组
 @param k 第几个元素
 @return 返回值
 */
- (NSArray *)topKFrequent:(NSArray *)nums k:(int)k
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (int i = 0; i < nums.count; i++) {
        if (dic[nums[i]]) {
            NSInteger tmp = [dic[nums[i]] integerValue];
            tmp += 1;
            dic[nums[i]] = @(tmp);
        }else {
            dic[nums[i]] = @(1);
        }
    }
    NSArray *keys = dic.allKeys;
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for (NSNumber *key in keys) {
        if (result.count < k) {
            result[key] = dic[key];
        }else {
            NSArray *tmpKeys = result.allKeys;
            NSNumber *minNum = @(GID_MAX);
            NSNumber *minKey;
            // 找到最小的key
            for (int i = 0; i < tmpKeys.count; i++) {
                if ([result[tmpKeys[i]] integerValue] < [minNum integerValue]) {
                    minKey = tmpKeys[i];
                    minNum = result[tmpKeys[i]];
                }
            }
            if (minKey && [minNum integerValue] < [dic[key] integerValue]) {
                result[key] = dic[key];
                [result removeObjectForKey:minKey];
            }
        }
    }
    return result.allKeys;
}





@end
