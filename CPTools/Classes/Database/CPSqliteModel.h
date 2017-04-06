//
//  CPSqliteModel.h
//  Database
//
//  Created by 曹培 on 17/4/5.
//  Copyright © 2017年 PetCao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPDatabaseProtocol.h"

@interface CPSqliteModel : NSObject


/**
 构建表名

 @param modelClass 数据模型类
 @return 表名
 */
+ (NSString *)tableNameWithClass: (Class)modelClass;

/**
 获取主键

 @param modelClass 数据模型类
 @return 主键
 */
+ (NSString *)primaryKeyWithClass: (Class)modelClass;

/**
 构建SQL语句所需的（字段名 字段类型）字符串

 @param modelClass 数据模型类
 @return （字段名 字段类型）字符串
 */
+ (NSString *)modelIvarNameAndSqliteTypeStrWithClass: (Class)modelClass;

/**
 构建标准数据库类型（字段名 字段类型）字典集

 @param modleClass 数据模型类
 @return （字段名 字段类型）字典集
 */
+ (NSDictionary *)modelIvarNameAndSqliteTypeWithClass: (Class)modleClass;

/**
 构建原始OC类型（字段名 字段类型）字典集
 
 @param modleClass 数据模型类
 @return （字段名 字段类型）字典集
 */
+ (NSDictionary *)modelIvarNameAndIvarTypeWithClass:(Class)modleClass;

@end
