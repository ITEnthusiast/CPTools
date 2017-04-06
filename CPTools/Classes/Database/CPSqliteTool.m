//
//  CPSqliteTool.m
//  Database
//
//  Created by 曹培 on 17/3/29.
//  Copyright © 2017年 PetCao. All rights reserved.
//

#import "CPSqliteTool.h"
#import "sqlite3.h"

#define kCache NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject

@implementation CPSqliteTool

sqlite3 *ppDb;

+(BOOL)dealSQL:(NSString *)SQL uid:(NSString *)uid {
    
    // 打开数据库
    if (![self openDatabaseWithUID:uid]) {
        NSLog(@"数据库打开失败");
    };
    
    // 执行数据库语句
    BOOL result = sqlite3_exec(ppDb, SQL.UTF8String, nil, nil, nil) == SQLITE_OK;
    if (result) {
        NSLog(@"执行成功");
    }
    
    // 关闭数据库
    [self closeDatabase];
    
    return YES;
}

+(NSArray<NSDictionary *> *)querySQL:(NSString *)SQL uid:(NSString *)uid {
    
    return nil;
}

+(BOOL)openDatabaseWithUID:(NSString *)uid {
    
    
    NSString *dbPath = [kCache stringByAppendingPathComponent: @"common.sqlite"];
    if (uid.length > 0) {
        dbPath = [kCache stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite", uid]];
    }
    
    /// fileName: 数据库路径
    /// ppDb: 一个已经打开的数据库
    
    BOOL result = sqlite3_open(dbPath.UTF8String, &ppDb) == SQLITE_OK;
    
    if (result) {
        NSLog(@"数据库创建并打开成功");
    }else
        NSLog(@"数据库创建并打开失败");
    
    return result;
}

+(void)closeDatabase {
    sqlite3_close(ppDb);
}

@end
