//
//  ViewController.m
//  PickerDemo
//
//  Created by yh on 16/8/23.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "HRDatePicker.h"
#import "HRStringPicker.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
//    [HRStringPicker showIn:self withItems:@[@"我不想买了",@"东西不好看",@"心里急的很"] handle:^(NSInteger currentIndex) {
//        NSLog(@"%ld",currentIndex);
//    }];
    [HRDatePicker showIn:self handle:^(UIDatePicker *picker) {
        NSLog(@"%@",picker);
    }];
}

@end
