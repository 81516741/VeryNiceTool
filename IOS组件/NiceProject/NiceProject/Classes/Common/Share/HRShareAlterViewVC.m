//
//  LDAlterViewVC.m
//  Gmcchh
//
//  Created by ld on 16/9/6.
//  Copyright © 2016年 KingPoint. All rights reserved.
//

#import "HRShareAlterViewVC.h"
#import "HRObject.h"
#import "HRConst.h"
#import "HRQQApiManager.h"
#import "HRWChatApiManager.h"
#import "HRSinaApiManager.h"

@interface HRShareAlterViewVC ()
@property (weak, nonatomic) IBOutlet UIView *alterView;
@end

@implementation HRShareAlterViewVC

+(void)show{
    HRShareAlterViewVC * alterVC = [[HRShareAlterViewVC alloc]init];
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

- (IBAction)qqShare:(id)sender
{
    [[HRQQApiManager share]shareToTencent:QQShareTypeFriend title:@"fdsa" des:@"没有描述" image:[UIImage imageNamed:@"Exclusive_ Circle"] url:@"www.baidu.com"];
    
    [self dismissViewControllerAnimated:false completion:nil];
}

- (IBAction)qqZoneShare:(id)sender
{
    [self dismissViewControllerAnimated:false completion:nil];
}

- (IBAction)wchatCircleShare:(UIButton *)sender
{
    [[HRWChatApiManager share]shareToWXScene:1 image:[UIImage imageNamed:@"Exclusive_ Circle"]];
    [self dismissViewControllerAnimated:false completion:nil];
}


- (IBAction)sinaShare:(UIButton *)sender
{
    __weak typeof(self) selfWeak = self;
    [[HRSinaApiManager share] sinaShare:^{
        [selfWeak dismissViewControllerAnimated:false completion:nil];
    } failure:^{
        [selfWeak dismissViewControllerAnimated:false completion:nil];
    }];
    self.view.hidden = true;
    
}

-(void)dealloc
{
    HRLog(@"第三方登录显示vc被消灭了");
}

@end
