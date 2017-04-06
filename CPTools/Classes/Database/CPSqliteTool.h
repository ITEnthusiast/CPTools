//
//  CPSqliteTool.h
//  Database
//
//  Created by 曹培 on 17/3/29.
//  Copyright © 2017年 PetCao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPSqliteTool : NSObject

/**
 处理增、删、改操作数据库

 @param SQL sql语句
 @param uid 用户id
 @return 操作是否成功
 */
+ (BOOL)dealSQL:(NSString *)SQL uid:(NSString *)uid;

/**
 处理查操作数据库

 @param SQL sql语句
 @param uid 用户id
 @return 查询结果
 */
+ (NSArray <NSDictionary *>*)querySQL:(NSString *)SQL uid:(NSString *)uid;

@end
