//
//  LeftVC.m
//  导航控制器
//
//  Created by ld on 16/9/19.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "LeftVC.h"
#import "PushedVC.h"

@interface LeftVC ()

@end

@implementation LeftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)jump:(id)sender
{
    PushedVC * vc = [[PushedVC alloc]init];
    [HRFunctionTool pushViewController:vc animated:true];
}

@end
