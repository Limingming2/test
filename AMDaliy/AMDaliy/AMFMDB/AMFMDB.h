//
//  AMFMDB.h
//  AMDaliy
//
//  Created by 李明明 on 2018/4/14.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMFMDB : NSObject

// 增删改查，创建

@property (nonatomic, strong) NSString *path;

- (void)insertObj:(id)obj;

- (void)deleteObjWithIndex:(id)index;

- (void)updateObjWithIndex:(id)index withObject:(id)obj;

- (id)objOfIndex:(id)index;

@end
