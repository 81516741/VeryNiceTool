//
//  ViewController.m
//  无数据提示控件
//
//  Created by yh on 16/8/23.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "HRTipVC.h"
@interface ViewController ()
@property (nonatomic,weak) HRTipVC * tipVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    [self.tipVC showWithhander:^(HRTipVC *tipVC) {
        
    }];
}

-(HRTipVC *)tipVC
{
    if (_tipVC == nil) {
        _tipVC =[HRTipVC initInVC:self];
        _tipVC.message = @"不要点击我";
    }
    return  _tipVC;
}
@end
