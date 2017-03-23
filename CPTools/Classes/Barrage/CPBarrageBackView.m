//
//  CPBarrageBackView.m
//  Pods
//
//  Created by 曹培 on 17/3/22.
//
//

#import "CPBarrageBackView.h"
#import "CALayer+Control.h"

#define kClockSec 0.1
#define kTrackCount 5

@interface CPBarrageBackView()
{
    bool _isPause;
}

@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *waitTimes;
@property (nonatomic, strong) NSMutableArray *leftTimes;

@property (nonatomic, strong) NSMutableArray *barrageViews;

@property (nonatomic, strong) NSMutableArray <id<CPBarrageModelProtocol>>* barrageModels;

@end

@implementation CPBarrageBackView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.layer setMasksToBounds:YES];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
        [self addGestureRecognizer:tapGesture];
    };
    return self;
}

-(NSTimer *)timer {
    if (!_timer) {
        NSTimer *timer = [NSTimer timerWithTimeInterval:kClockSec target:self selector:@selector(update) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        _timer = timer;
    }
    return _timer;
}

-(NSMutableArray *)waitTimes {
    if (!_waitTimes) {
        _waitTimes = [NSMutableArray arrayWithCapacity:kTrackCount];
        for (int i=0; i<kTrackCount; i++) {
            _waitTimes[i] = @0.0;
        }
    }
    return _waitTimes;
}

-(NSMutableArray *)leftTimes {
    if (!_leftTimes) {
        _leftTimes = [NSMutableArray arrayWithCapacity:kTrackCount];
        for (int i=0; i<kTrackCount; i++) {
            _leftTimes[i] = @0.0;
        }
    }
    return _leftTimes;
}

-(NSMutableArray *)barrageViews {
    if (!_barrageViews) {
        _barrageViews = [NSMutableArray array];
    }
    return _barrageViews;
}

-(NSMutableArray<id<CPBarrageModelProtocol>> *)barrageModels {
    if (!_barrageModels) {
        _barrageModels = [NSMutableArray array];
    }
    return _barrageModels;
}

-(void)didMoveToSuperview {
    [self timer];
}

-(void)addBarrageModels:(NSArray *)barrageModels {
    [self.barrageModels addObjectsFromArray:barrageModels];
    
    // 根据 beginTime 排序
    [self.barrageModels sortUsingComparator:^NSComparisonResult(id<CPBarrageModelProtocol>  _Nonnull obj1, id<CPBarrageModelProtocol>  _Nonnull obj2) {
        if (obj1.beginTime < obj2.beginTime) {
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    }];

}

- (void)update {
    
    if (_isPause) {
        return;
    }
    
    for (int i = 0; i<kTrackCount; i++) {
        NSTimeInterval waitTime = [self.waitTimes[i] doubleValue] - kClockSec;
        if (waitTime <= 0.0) {
            waitTime = 0.0;
        }
        self.waitTimes[i] = @(waitTime);
        
        NSTimeInterval leftTime = [self.leftTimes[i] doubleValue] - kClockSec;
        if (leftTime <= 0.0) {
            leftTime = 0.0;
        }
        self.leftTimes[i] = @(leftTime);
    }
    
    // 检测弹幕模型里有哪些模型需要发送
    
    
    
    NSMutableArray *deledateModels = [NSMutableArray array];
    for (id<CPBarrageModelProtocol>model in self.barrageModels) {
        // 判断发送时间是否到达，否则break；
        NSTimeInterval beginTime = model.beginTime;
        NSTimeInterval currentTime = [self.delegate currentTime];
        if (beginTime > currentTime) {
            break;
        }
        
        // 进一步检测能不能发送(检测是否满足碰撞机制)
        if ([self checkTrackWithBarrageModel:model]) {
            [deledateModels addObject:model];
        }
    }
    [self.barrageModels removeObjectsInArray:deledateModels];
    
}

- (BOOL)checkTrackWithBarrageModel:(id<CPBarrageModelProtocol>)model {
    
    CGFloat barrageHeight = self.frame.size.height/kTrackCount;
    
    // 遍历所有的弹道，依次判断是否会产生碰撞
    for (int i=0; i<kTrackCount; i++) {
        
        // 判断是否会产生碰撞
        NSTimeInterval waitTime = [self.waitTimes[i] doubleValue];
        if (waitTime > 0.0) {
            continue;
        }
        UIView *barrageView = [self.delegate barrageViewWithBarrageModel:model];
        NSTimeInterval speed = (self.frame.size.width+barrageView.frame.size.width)/model.liveTime;
        
        NSTimeInterval leftTime = [self.leftTimes[i] doubleValue];
        
        double leftDistance = speed * leftTime;
        
        if (leftDistance > self.frame.size.width) {
            continue;
        }
        
        [self.barrageViews addObject:barrageView];
        
        self.waitTimes[i] = @(barrageView.frame.size.width / speed);
        self.leftTimes[i] = @(model.liveTime);
        
        
        // 发送
        CGRect frame = barrageView.frame;
        frame.origin.x = self.frame.size.width;
        frame.origin.y = barrageHeight * i;
        barrageView.frame = frame;
        [self addSubview:barrageView];
        
        [UIView animateWithDuration:model.liveTime delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            CGRect frame = barrageView.frame;
            frame.origin.x = - barrageView.frame.size.width;
            frame.origin.y = barrageHeight * i;
            barrageView.frame = frame;
        } completion:^(BOOL finished) {
            [barrageView removeFromSuperview];
            [self.barrageViews removeObject:barrageView];
        }];
        return YES;
    }
    return NO;
}

-(void)pause {
    _isPause = YES;
    [[self.barrageViews valueForKeyPath:@"layer"] makeObjectsPerformSelector:@selector(pauseAnimate)];
}

-(void)resume {
    _isPause = NO;
    [[self.barrageViews valueForKeyPath:@"layer"] makeObjectsPerformSelector:@selector(resumeAnimate)];
}

- (void)click:(UIGestureRecognizer *)gesture {
//    CGPoint point = [gesture locationInView:self];
//    for (UIView *barrageView in self.barrageViews) {
//        CGRect barragePresentationFrame = CGRectNull;
//        if (barrageView.layer.presentationLayer) {
//            barragePresentationFrame = barrageView.layer.presentationLayer.frame;
//        }
//        if (CGRectContainsPoint(barragePresentationFrame, point)) {
//            if ([self.delegate respondsToSelector:@selector(barrageBackViewDidClickBarrageView:point:)]) {
//                [self.delegate barrageBackViewDidClickBarrageView:barrageView point:point];
//                break;
//            }
//        }
//    }
}

@end
