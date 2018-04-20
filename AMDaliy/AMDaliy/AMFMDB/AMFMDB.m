//
//  AMFMDB.m
//  AMDaliy
//
//  Created by 李明明 on 2018/4/14.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import "AMFMDB.h"
#import <FMDB/FMDB.h>

@interface AMFMDB ()

@property (nonatomic, strong) FMDatabase *database;

@end

@implementation AMFMDB

- (void)insertObj:(id)obj
{
    if ([self.database open]) {
        FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:self.path];
        [queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
            
        }];
        
        [self.database close];
    }
}

- (void)deleteObjWithIndex:(id)index
{
    
}

- (void)updateObjWithIndex:(id)index withObject:(id)obj
{
    
}

- (id)objOfIndex:(id)index
{
    return nil;
}

#pragma mark - getter and setter

- (FMDatabase *)database
{
    if (_database) {
        FMDatabase *database = [FMDatabase databaseWithPath:self.path];
        
        _database = database;
    }
    return _database;
}

@end
