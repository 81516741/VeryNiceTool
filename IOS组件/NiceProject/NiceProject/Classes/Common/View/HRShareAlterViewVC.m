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

- (IBAction)qqFriendShare:(id)sender
{
    [HRQQApiManager QQShare:QQShareTypeFriend title:@"😘蓉" des:@"这是一个感人肺腑的乡村爱情故事😉" image:[UIImage imageNamed:@"ta"] url:@"www.baidu.com" success:^{
        
    } failure:^(NSString *message) {
        
    }];
    
    [self dismissViewControllerAnimated:false completion:nil];
}

- (IBAction)qqZoneShare:(id)sender
{
    [HRQQApiManager QQShare:QQShareTypeZone title:@"😘蓉" des:@"这是一个感人肺腑的乡村爱情故事😉" image:[UIImage imageNamed:@"ta"] url:@"www.baidu.com" success:^{
        
    } failure:^(NSString *message) {
        
    }];
    [self dismissViewControllerAnimated:false completion:nil];
}

- (IBAction)wchatFriendShare:(UIButton *)sender
{
    [HRWChatApiManager WChatShare:WChatShareTypeFriend title:@"😘蓉" des:@"这是一个感人肺腑的乡村爱情故事😉" image:[UIImage imageNamed:@"ta"] url:@"www.baidu.com" success:^{
        
    } failure:^(NSString *message) {
        
    }];
    [self dismissViewControllerAnimated:false completion:nil];
}

- (IBAction)wchatCircleShare:(UIButton *)sender
{
    [HRWChatApiManager WChatShare:WChatShareTypeCircle title:@"😘蓉" des:@"这是一个感人肺腑的乡村爱情故事😉" image:[UIImage imageNamed:@"ta"] url:@"www.baidu.com" success:^{
        
    } failure:^(NSString *message) {
        
    }];
    [self dismissViewControllerAnimated:false completion:nil];
}


- (IBAction)sinaShare:(UIButton *)sender
{
    __weak typeof(self) selfWeak = self;
    [HRSinaApiManager sinaShareText:@"就是这个达www.baidu.com" image:[UIImage imageNamed:@"ta"] success:^{
        
    } failure:^(NSString *message) {
        
    }];
    [selfWeak dismissViewControllerAnimated:false completion:nil];
    
}

-(void)dealloc
{
    HRLog(@"第三方登录显示vc被消灭了");
}

@end
