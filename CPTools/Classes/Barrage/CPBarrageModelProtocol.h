//
//  CPBarrageModelProtocol.h
//  Pods
//
//  Created by 曹培 on 17/3/22.
//
//
@protocol CPBarrageModelProtocol <NSObject>

/// 何时发送
@property (nonatomic, assign, readonly) NSTimeInterval beginTime;

/// 全程历时多久
@property (nonatomic, assign, readonly) NSTimeInterval liveTime;
//@property (nonatomic, assign) NSTimeInterval leftTime;

@end
