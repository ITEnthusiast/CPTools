//
//  CPViewController.m
//  CPTools
//
//  Created by admin@caopei.cn on 03/21/2017.
//  Copyright (c) 2017 admin@caopei.cn. All rights reserved.
//

#import "CPViewController.h"
#import <CPTools/CPBarrageBackView.h>
#import "CPBarrageModel.h"

@interface CPViewController ()<CPBarrageBackViewDelegate>

@property (nonatomic, weak) CPBarrageBackView *barrageView;

@end

@implementation CPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self barrageTest];
}

#pragma mark - 弹幕
- (void)barrageTest {
    
    // 1.创建弹幕模型
    CPBarrageBackView *barrageView = [[CPBarrageBackView alloc] initWithFrame:CGRectMake(50, 100, 300, 200)];
    barrageView.delegate = self;
    barrageView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:barrageView];
    
    self.barrageView = barrageView;
    // 2.添加到弹幕背景控件里
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 添加弹幕模型
    CPBarrageModel *model1 = [[CPBarrageModel alloc] init];
    model1.title = @"时尚芭莎";
    model1.beginTime = 2;
    model1.liveTime = 6;
    
    CPBarrageModel *model2 = [[CPBarrageModel alloc] init];
    model2.title = @"时尚健康";
    model2.beginTime = 3;
    model2.liveTime = 3;
    
    [self.barrageView addBarrageModels:@[model1, model2]];
}
- (IBAction)pause:(id)sender {
    [self.barrageView pause];
}
- (IBAction)resume:(id)sender {
    [self.barrageView resume];
}

-(NSTimeInterval)currentTime {
    static double time = 0.0;
    time += 0.2;
    
    return time;
}

-(UIView *)barrageViewWithBarrageModel:(CPBarrageModel *)model {
    UILabel *label = [[UILabel alloc] init];
    label.text = model.title;
    [label sizeToFit];
    return label;
}

-(void)barrageBackViewDidClickBarrageView:(UIView *)view point:(CGPoint)point {
    NSLog(@"点我干啥:\n信息：%@\n坐标：%@", view, NSStringFromCGPoint(point));
}

@end
