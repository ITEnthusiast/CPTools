//
//  CPBarrageModel.h
//  CPTools
//
//  Created by 曹培 on 17/3/22.
//  Copyright © 2017年 admin@caopei.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CPTools/CPBarrageModelProtocol.h>

@interface CPBarrageModel : NSObject
/// 何时发送
@property (nonatomic, assign) NSTimeInterval beginTime;

/// 全程历时多久
@property (nonatomic, assign) NSTimeInterval liveTime;

@property (nonatomic, copy) NSString *title;

@end
