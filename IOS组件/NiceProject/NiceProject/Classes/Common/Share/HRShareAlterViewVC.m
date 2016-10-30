//
//  LDAlterViewVC.m
//  Gmcchh
//
//  Created by ld on 16/9/6.
//  Copyright © 2016年 KingPoint. All rights reserved.
//

#import "HRShareAlterViewVC.h"

@interface HRShareAlterViewVC ()
@property (nonatomic, copy) void(^sureActionBlock)();
@property (weak, nonatomic) IBOutlet UIView *alterView;
@end

@implementation HRShareAlterViewVC

+(void)showIn:(UIViewController *)vc handle:(void(^)()) handle
{
    HRShareAlterViewVC * alterVC = [[HRShareAlterViewVC alloc]init];
    alterVC.sureActionBlock = handle;
    [vc presentViewController:alterVC animated:YES completion:nil];
}

-(void)viewDidLoad
{
    self.alterView.transform = CGAffineTransformMakeScale(0, 0);
    self.alterView.alpha = 0;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.25 animations:^{
        self.alterView.transform = CGAffineTransformIdentity;
        self.alterView.alpha = 1;
    }];
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
