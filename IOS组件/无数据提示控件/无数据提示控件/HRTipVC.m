//
//  HRTipVC.m
//  DriveCloudPhone
//
//  Created by yh on 16/5/21.
//  Copyright © 2016年 yh. All rights reserved.
//

#import "HRTipVC.h"

@interface HRTipVC ()

@property (weak, nonatomic) IBOutlet UILabel *messageLable;
@property(nonatomic,strong)void(^hander)(HRTipVC * tipVC);
@end

@implementation HRTipVC

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.hander) {
        self.hander(self);
    }
}

- (void)hideView
{
    self.view.hidden = YES;
}

-(void)showWithhander:(void (^)(HRTipVC *))hander
{
    self.view.hidden = NO;
    self.hander = hander;
}

+(instancetype)initInVC:(UIViewController *)desVC
{
    HRTipVC * tipVC = [[HRTipVC alloc]init];
    tipVC.view.frame = desVC.view.bounds;
    tipVC.view.hidden = YES;
    [desVC addChildViewController:tipVC];
    [desVC.view addSubview:tipVC.view];
    [desVC.view bringSubviewToFront:tipVC.view];
    return tipVC;
}

-(void)setMessage:(NSString *)message
{
    _message = message;
    self.messageLable.text = message;
}
@end
