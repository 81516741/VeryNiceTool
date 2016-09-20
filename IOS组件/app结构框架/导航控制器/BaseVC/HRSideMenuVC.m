//
//  HRSideMenuVC.m
//  导航控制器
//
//  Created by ld on 16/9/20.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRSideMenuVC.h"

@interface HRSideMenuVC ()

@end

@implementation HRSideMenuVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundImage = [UIImage imageNamed:@"Stars"];
        self.menuPreferredStatusBarStyle = UIStatusBarStyleLightContent;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
