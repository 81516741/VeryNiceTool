//
//  HRTabVC.m
//  导航控制器
//
//  Created by ld on 16/9/19.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRTabVC.h"
#import "HRItemNC.h"
#import "HRFunctionTool.h"
#import "HRObject.h"

@interface HRTabVC ()

@end

@implementation HRTabVC

+(instancetype)tabVC:(NSArray<NSString *> *)names titles:(NSArray<NSString *> *)titles imagePres:(NSArray<NSString *> *)imagePres
{
    HRTabVC * tabVC = [[HRTabVC alloc]init];
    for (int i = 0; i < names.count; i ++) {
        Class itemClass = NSClassFromString(names[i]);
        NSAssert(itemClass!=nil, @"中间控制器(%@)不存在",names[i]);
        NSString * title = titles[i];
        NSString * imagePre = imagePres[i];
        UIViewController * vc = [self vc:[[itemClass alloc]init] title:title imagePre:imagePre];
        [tabVC addChildViewController:vc];
    }
    return tabVC;
}

+(UIViewController *)vc:(UIViewController *)vc title:(NSString *)title imagePre:(NSString *)imagePre
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",imagePre]];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imagePre]];
    return vc;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self configNaviLeftItems];
    [self configNaviRightItems];
}

#pragma mark - 导航条的UI配置
-(void)configNaviLeftItems
{
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(-20, 0, 110, 25)];
    [button setImage:[UIImage imageNamed:@"second_selected"] forState:UIControlStateNormal];
    [button setContentMode:UIViewContentModeScaleAspectFit];
    [button setTitle:@"左边抽屉" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showLeftVC) forControlEvents:UIControlEventTouchUpInside];
    //为了使图片可以更靠左边
    UIView * item1View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 110, 25)];
    [item1View addSubview:button];
    UIBarButtonItem * item1 = [[UIBarButtonItem alloc]initWithCustomView:item1View];
    self.navigationItem.leftBarButtonItem = item1;
}
-(void)configNaviRightItems
{
    
    UIBarButtonItem * item1 = [[UIBarButtonItem alloc]initWithTitle:@"蓉达" style:UIBarButtonItemStylePlain target:self action:@selector(jumpTpNextVC)];
    UIBarButtonItem * item2 = [[UIBarButtonItem alloc]initWithTitle:@"show" style:UIBarButtonItemStylePlain target:self action:@selector(jumpTpNextVC)];
    UIBarButtonItem * item3 = [[UIBarButtonItem alloc]initWithTitle:@"time" style:UIBarButtonItemStylePlain target:self action:@selector(jumpTpNextVC)];
    self.navigationItem.rightBarButtonItems = @[item2,item1];
    if (self.selectedIndex == 1) {
        self.navigationItem.rightBarButtonItems = @[item3,item2,item1];
    }
}

#pragma mark - 点击事件
-(void)showLeftVC
{
    [[HRObject share].menuVC presentLeftMenuViewController];
}

-(void)jumpTpNextVC
{
    [HRFunctionTool gotoPushVC];
}

@end
