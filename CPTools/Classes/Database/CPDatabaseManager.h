//
//  CPDatabaseManager.h
//  Database
//
//  Created by 曹培 on 17/4/5.
//  Copyright © 2017年 PetCao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPDatabaseManager : NSObject

/**
 保存数据

 @param model 数据对象
 @param uid 用户id
 @return 操作是否成功
 */
+ (BOOL)saveModel:(id)model UID:(NSString *)uid;

/**
 获取数据

 @param modelClass 数据对象类名
 @param uid 用户id
 @return 数据对象
 */
+ (id)findModel:(Class)modelClass UID:(NSString *)uid;

/**
 删除数据

 @param modelClass 数据对象类名
 @param uid 用户id
 @return 是否操作成功
 */
+ (BOOL)deleteModel:(Class)modelClass UID:(NSString *)uid;


@end
