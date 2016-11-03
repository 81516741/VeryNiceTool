//
//  LDAlterViewVC.m
//  Gmcchh
//
//  Created by ld on 16/9/6.
//  Copyright © 2016年 KingPoint. All rights reserved.
//

#import "HRThirdAlterViewVC.h"
#import "HRConst.h"
#import "HRObject.h"
#import "HRQQApiManager.h"
#import "HRWChatApiManager.h"
#import "HRSinaApiManager.h"

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
    [HRQQApiManager QQLoginSuccess:^{
        HRLog(@"qq登录成功");
    } failure:^(QQLoginFailure failure) {
        HRLog(@"qq登录失败");
    } userInfo:^(APIResponse *userInfo) {
        HRLog(@"qq用户信息-->%@",userInfo);
    }];
    [self dismissViewControllerAnimated:false completion:nil];
}
- (IBAction)wchatLogin:(UIButton *)sender
{
    [HRWChatApiManager wchatLogin];
    [self dismissViewControllerAnimated:false completion:nil];
}


-(void)dealloc
{
    HRLog(@"第三方登录显示vc被消灭了");
}

@end
