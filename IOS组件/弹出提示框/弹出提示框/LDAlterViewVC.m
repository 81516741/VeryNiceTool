//
//  LDAlterViewVC.m
//  Gmcchh
//
//  Created by ld on 16/9/6.
//  Copyright © 2016年 KingPoint. All rights reserved.
//

#import "LDAlterViewVC.h"

@interface LDAlterViewVC ()
@property (nonatomic, copy) void(^sureActionBlock)();
@end

@implementation LDAlterViewVC

+(void)showIn:(UIViewController *)vc handle:(void(^)()) handle
{
    LDAlterViewVC * alterVC = [[LDAlterViewVC alloc]init];
    alterVC.sureActionBlock = handle;
    [vc presentViewController:alterVC animated:YES completion:nil];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}
- (IBAction)bViewClick:(UIButton *)sender
{
    [self dismissViewControllerAnimated:false completion:nil];
}
- (IBAction)goVIPBtnClick:(UIButton *)sender
{
    if (self.sureActionBlock) {
        self.sureActionBlock();
        [self dismissViewControllerAnimated:false completion:nil];
    }
}

@end
