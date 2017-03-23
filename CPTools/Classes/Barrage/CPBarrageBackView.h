//
//  CPBarrageBackView.h
//  Pods
//
//  Created by 曹培 on 17/3/22.
//
//

#import <UIKit/UIKit.h>
#import "CPBarrageModelProtocol.h"

@protocol CPBarrageBackViewDelegate <NSObject>

@property (nonatomic, assign, readonly)NSTimeInterval currentTime;

- (UIView *)barrageViewWithBarrageModel:(id<CPBarrageModelProtocol>)model;

- (void)barrageBackViewDidClickBarrageView:(UIView *)view point:(CGPoint)point;

@end

@interface CPBarrageBackView : UIView

@property (nonatomic, weak)id<CPBarrageBackViewDelegate>delegate;

- (void)addBarrageModels:(NSArray*)barrageModels;

- (void)pause;

- (void)resume;

@end
