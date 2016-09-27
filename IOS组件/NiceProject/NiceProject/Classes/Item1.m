//
//  Item1.m
//  导航控制器
//
//  Created by ld on 16/9/19.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "Item1.h"
#import "VIPCenterModel.h"
@interface Item1 ()

@end

@implementation Item1

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    [HRHTTPTool text:kTextTaskDescription dataClass:[VIPCenterModel class] success:^(HRHTTPModel *responseObject) {
        HRLog(@"成功");
    } failure:^(HRHTTPModel *responseObject) {
        
    }];
}


@end
