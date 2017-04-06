//
//  CPDatabaseManager.m
//  Database
//
//  Created by 曹培 on 17/4/5.
//  Copyright © 2017年 PetCao. All rights reserved.
//

#import "CPDatabaseManager.h"
#import "CPSqliteTool.h"
#import "CPSqliteModel.h"
#import <objc/runtime.h>

@implementation CPDatabaseManager

+(BOOL)createTable:(Class)modelClass uid:(NSString *)uid {
    
    // 构建表名：tableName
    NSString *tableName = [CPSqliteModel tableNameWithClass:modelClass];
    
    // 获取主键：primaryKey
    NSString *primaryKey = [CPSqliteModel primaryKeyWithClass:modelClass];
    if (!primaryKey) {
        return NO;
    }
    
    // 构建字段串：nameTypeStr
    NSString *nameTypeStr = [CPSqliteModel modelIvarNameAndSqliteTypeStrWithClass:modelClass];
    
    // 构建SQL语句：sqlStr
    NSString *sqlStr = [NSString stringWithFormat:@"create table if not exists %@(%@, primary key(%@))", tableName, nameTypeStr, primaryKey];
    
    // 执行SQL语句
    if ([CPSqliteTool dealSQL:sqlStr uid:uid]) {
        return YES;
    }else
        return NO;
}
+(BOOL)saveModel:(id)model UID:(NSString *)uid {
    
    [self createTable:[model class] uid:uid];
    return NO;
}

+(id)findModel:(Class)modelClass UID:(NSString *)uid {
    id result = [CPSqliteTool querySQL:@"" uid:uid];
    return result;
}

+(BOOL)deleteModel:(Class)modelClass UID:(NSString *)uid {
    if ([CPSqliteTool dealSQL:@"" uid:uid]) {
        return YES;
    }
    return NO;
}

@end
