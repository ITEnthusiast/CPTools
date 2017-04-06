//
//  CPDatabaseProtocol.h
//  Database
//
//  Created by 曹培 on 17/4/6.
//  Copyright © 2017年 PetCao. All rights reserved.
//

#import "Foundation/Foundation.h"

@protocol CPDatabaseDelegate <NSObject>

+ (NSString *)primaryKey;

@end
