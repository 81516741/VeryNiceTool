//
//  ViewController.m
//  xibObj的使用
//
//  Created by yh on 16/8/22.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "LoginVCViewController.h"
#import "HRCounting.h"

@implementation ViewController

- (void)viewDidLoad {
    
}

- (IBAction)loginUI:(id)sender
{
    [self presentViewController:[LoginVCViewController new] animated:true completion:nil];
}


@end
