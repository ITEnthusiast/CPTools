//
//  CPSqliteModel.m
//  Database
//
//  Created by 曹培 on 17/4/5.
//  Copyright © 2017年 PetCao. All rights reserved.
//

#import "CPSqliteModel.h"
#import <objc/runtime.h>

@implementation CPSqliteModel

+(NSString *)tableNameWithClass:(Class)modelClass {
    return NSStringFromClass(modelClass);
}

+(NSString *)primaryKeyWithClass:(Class)modelClass {
    if (![modelClass respondsToSelector:@selector(primaryKey)]) {
        NSLog(@"若存储此模型，必须在模型类中实现primaryKey方法");
        return nil;
    }
    return [modelClass primaryKey];
}

+(NSString *)modelIvarNameAndSqliteTypeStrWithClass:(Class)modelClass {
    NSDictionary *nameTypeDic = [self modelIvarNameAndSqliteTypeWithClass:modelClass];
    NSMutableArray *array = [NSMutableArray array];
    [nameTypeDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *string = [NSString stringWithFormat:@"%@ %@", key, obj];
        [array addObject:string];
    }];
    return [array componentsJoinedByString:@","];
}

+(NSDictionary *)modelIvarNameAndSqliteTypeWithClass:(Class)modleClass {
    NSDictionary *nameTypeDic = [self modelIvarNameAndIvarTypeWithClass:modleClass];
    NSMutableDictionary *dicResult = [NSMutableDictionary dictionary];
    [nameTypeDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [dicResult setObject:[self ivarTypeToSqliteType][obj] forKey:key];
    }];
    return dicResult;
}

+(NSDictionary *)modelIvarNameAndIvarTypeWithClass:(Class)modleClass {

    unsigned int outCount;
    Ivar *ivarList = class_copyIvarList(modleClass, &outCount);
    NSMutableDictionary *dicResult = [NSMutableDictionary dictionary];
    for (int i = 0; i < outCount; i++) {
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivarList[i])];
        if ([ivarName hasPrefix:@"_"]) {
            ivarName = [ivarName substringFromIndex:1];
        }
        NSString *ivarType = [[NSString stringWithUTF8String:ivar_getTypeEncoding(ivarList[i])] stringByTrimmingCharactersInSet:([NSCharacterSet characterSetWithCharactersInString:@"@\""])];
        
        [dicResult setValue:ivarType forKey:ivarName];
    }
    return dicResult;
}

/**
 OC->Sqlite 类型映射表

 @return Sqlite数据类型
 */
+(NSDictionary *)ivarTypeToSqliteType {
    return @{
             @"d": @"real", // double
             @"f": @"real", // float
             
             @"i": @"integer",  // int
             @"q": @"integer", // long
             @"Q": @"integer", // long long
             @"B": @"integer", // bool
             
             @"NSData": @"blob",
             @"NSDictionary": @"text",
             @"NSMutableDictionary": @"text",
             @"NSArray": @"text",
             @"NSMutableArray": @"text",
             
             @"NSString": @"text"
             };
}
@end
