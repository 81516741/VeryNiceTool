//
//  ViewController.m
//  宫格布局
//
//  Created by ld on 16/9/8.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "TextView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *myVIew;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [TextView showIn:self.view models:@[@"fdsaf",@"fdsaf",@"fdsaf",@"fdsaf",@"fdsaf",@"fdsaf",@"fdsaf",@"fdsaf",@"fdsaf",@"fdsaf",@"fdsaf",@"fdsaf",@"fdsaf",@"fdsaf"]  itemH:50 col:2 startY:0 itemClick:^(NSInteger index) {
        NSLog(@"点击了的index是%ld",(long)index);
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  
}
@end
