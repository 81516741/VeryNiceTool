//
//  LDAlterViewVC.m
//  Gmcchh
//
//  Created by ld on 16/9/6.
//  Copyright © 2016年 KingPoint. All rights reserved.
//

#import "HRThirdAlterViewVC.h"
#import "HRThirdLoginTool.h"
#import "HRConst.h"
#import "HRObject.h"

@interface HRThirdAlterViewVC ()
@property (weak, nonatomic) IBOutlet UIView *alterView;
@end

@implementation HRThirdAlterViewVC

+(void)show
{
    HRThirdAlterViewVC * alterVC = [[HRThirdAlterViewVC alloc]init];
    [[HRObject share].rootNC presentViewController:alterVC animated:YES completion:nil];
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
        self.alterView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.alterView.alpha = 1;
        
    } completion:^(BOOL finished) {
        self.alterView.transform = CGAffineTransformIdentity;
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
- (IBAction)qqLogin:(id)sender
{
    [HRThirdLoginTool QQLoginSuccess:^{
        HRLog(@"qq登录成功");
        [self dismissViewControllerAnimated:false completion:nil];
    } failure:^(QQLoginFailure failure) {
        HRLog(@"qq登录失败");
        [self dismissViewControllerAnimated:false completion:nil];
    } userInfo:^(APIResponse *userInfo) {
        HRLog(@"qq用户信息-->%@",userInfo);
        [self dismissViewControllerAnimated:false completion:nil];
    }];
}


@end
