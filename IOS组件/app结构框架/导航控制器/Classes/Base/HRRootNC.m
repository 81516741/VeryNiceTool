//
//  HRRootNC.m
//  导航控制器
//
//  Created by ld on 16/9/19.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRRootNC.h"
#import "HRItemNC.h"
#import "HRTabVC.h"
#import "HRSideMenuVC.h"
#import "HRObject.h"
#import "HRFunctionTool.h"


@interface HRRootNC ()<UITabBarControllerDelegate,RESideMenuDelegate>
@property (nonatomic,weak) HRTabVC * tabVC;
@property (nonatomic,weak) HRSideMenuVC * menuVC;
@property (assign ,nonatomic) NSInteger selectedIndex;

@end

@implementation HRRootNC

+(instancetype)rootNC:(NSArray<NSString *> *)centerVCNames centerVCTitles:(NSArray<NSString *> *)titles centerVCImagePres:(NSArray<NSString *> *)imagePres leftVCName:(NSString *)leftVCName
{
    BOOL isReasonable = (centerVCNames.count == titles.count) && (centerVCNames.count == imagePres.count);
    NSAssert(isReasonable, @"centerVCNames & centerVCTitles & centerVCImagePres 数组的元素需相等");
    //创建menu中间的控制器
    HRTabVC * tabVC = [HRTabVC tabVC:centerVCNames titles:titles imagePres:imagePres];
    HRItemNC * centerNC = [[HRItemNC alloc]initWithRootViewController:tabVC];
    
    //创建menu左边的控制器
    Class leftVCClass = NSClassFromString(leftVCName);
    NSAssert(leftVCClass!=nil, @"左边控制器(%@)不存在",leftVCName);
    
    //创建带导航条的menu控制器
    HRSideMenuVC * sideMenuVC = [[HRSideMenuVC alloc]initWithContentViewController:centerNC leftMenuViewController:[[leftVCClass alloc]init] rightMenuViewController:nil];
    HRRootNC * rootNC = [[HRRootNC alloc]initWithRootViewController:sideMenuVC];
    sideMenuVC.delegate = rootNC;
    
    //给属性赋值
    tabVC.delegate = rootNC;
    rootNC.tabVC = tabVC;
    rootNC.selectedIndex = 0;
    rootNC.menuVC = sideMenuVC;
    [HRObject share].rootNC = rootNC;
    
    //配置导航条的UI
    [rootNC configNaviLeftItems];
    [rootNC configNaviRightItems];
    
    return rootNC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - tabbarVC的代理
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    self.selectedIndex = tabBarController.selectedIndex;
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
    self.tabVC.navigationItem.leftBarButtonItem = item1;
}
-(void)configNaviRightItems
{
    
    UIBarButtonItem * item1 = [[UIBarButtonItem alloc]initWithTitle:@"蓉达" style:UIBarButtonItemStylePlain target:self action:@selector(jumpTpNextVC)];
    UIBarButtonItem * item2 = [[UIBarButtonItem alloc]initWithTitle:@"show" style:UIBarButtonItemStylePlain target:self action:@selector(jumpTpNextVC)];
    UIBarButtonItem * item3 = [[UIBarButtonItem alloc]initWithTitle:@"time" style:UIBarButtonItemStylePlain target:self action:@selector(jumpTpNextVC)];
    self.tabVC.navigationItem.rightBarButtonItems = @[item2,item1];
    if (self.selectedIndex == 1) {
        self.tabVC.navigationItem.rightBarButtonItems = @[item3,item2,item1];
    }
}


#pragma mark - 点击事件
-(void)showLeftVC
{
    [self.menuVC presentLeftMenuViewController];
}

-(void)jumpTpNextVC
{
    [HRFunctionTool gotoPushVC];
}

#pragma mark - pop  push
-(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (self.childViewControllers.count >2) {
    }else{// count<=2 代表是回到rootvc
        self.navigationBar.hidden = true;
        self.tabBarController.tabBar.hidden = false;
        [self hideBackgroundView];
        
    }
    return [super popViewControllerAnimated:animated];
}

-(NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
{
    self.navigationBar.hidden = true;
    self.tabBarController.tabBar.hidden = false;
    [self hideBackgroundView];
    return [super popToRootViewControllerAnimated:animated];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers.count > 1) {//count > 1代表不是rootVC
        self.tabBarController.tabBar.hidden = true;
        self.navigationBar.hidden = false;
        [self showBackgroundView];
    }else{//这个是系统第一次push出rootvc调用，count = 1;
        self.navigationBar.hidden = true;
    }
}

#pragma mark - RESideMenu Delegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}


@end
