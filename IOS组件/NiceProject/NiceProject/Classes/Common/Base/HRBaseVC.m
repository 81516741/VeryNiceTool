//
//  ViewController.m
//  导航控制器
//
//  Created by ld on 16/9/19.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRBaseVC.h"

@interface HRBaseVC ()

@end

@implementation HRBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNaviLeftItems];
    [self configNaviRightItems];
}

#pragma mark - 导航条的UI配置
-(void)configNaviLeftItems
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"bg_backBarButton_normal"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"bg_backBarButton_hight"] forState:UIControlStateHighlighted];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor colorWithRed:49/255.0 green:130/255.0 blue:208/255.0 alpha:1] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor colorWithRed:120/199 green:120/255.0 blue:120/255.0 alpha:0.3] forState:UIControlStateHighlighted];
    [backButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    backButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [backButton sizeToFit];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
}

-(void)configNaviRightItems
{
    UISwitch * customSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(100, 100, 0, 0)];
    [customSwitch addTarget:self action:@selector(click) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:customSwitch];
}

#pragma mark - 点击事件

-(void)click
{
    [HRFunctionTool gotoFunction:kFunctionText needLogin:false];
}

-(void)back
{
    [HRFunctionTool popViewControllerAnimated:true];
}

#pragma  mark - 提示页面
-(UIView *)progressView
{
    if (_progressView == nil) {
        _progressView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        UIActivityIndicatorView * activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activity.center = CGPointMake(kScreenWidth * 0.5, kScreenHeight * 0.5);
        [activity startAnimating];
        [_progressView addSubview:activity];
        _progressView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_progressView];
        
    }
    return _progressView;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    HRLog(@"\n控制器 (%@) ------- 被销毁😭😭😭",NSStringFromClass(self.class));
}

@end
