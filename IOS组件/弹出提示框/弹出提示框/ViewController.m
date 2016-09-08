//
//  ViewController.m
//  弹出提示框
//
//  Created by ld on 16/9/8.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "LDAlterViewVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [LDAlterViewVC showIn:self handle:^{
        NSLog(@"执行点啥呢");
    }];
}

@end
