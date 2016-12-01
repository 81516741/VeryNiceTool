//
//  HRWeaveVC.m
//  NiceProject
//
//  Created by ld on 16/11/25.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRWeaveVC.h"
#import "HRWaterBallView.h"

@interface HRWeaveVC ()
@property (nonatomic,strong) HRWaterBallView * waterBallView;
@end

@implementation HRWeaveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    HRWaterBallView *progressView1 = [[HRWaterBallView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.waterBallView = progressView1;
    progressView1.center=CGPointMake(CGRectGetMidX(self.view.bounds), 270);
    progressView1.progress = 0.5;
    progressView1.waveHeight = 3;
    progressView1.speed = 1.0;
    progressView1.firstWaveColor = [UIColor colorWithRed:134/255.0 green:116/255.0 blue:210/255.0 alpha:1];
    progressView1.secondWaveColor = [UIColor colorWithRed:134/255.0 green:116/255.0 blue:210/255.0 alpha:0.5];
    [self.view addSubview:progressView1];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.waterBallView stopWaveAnimation];
}
@end
