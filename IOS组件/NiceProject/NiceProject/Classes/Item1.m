//
//  Item1.m
//  导航控制器
//
//  Created by ld on 16/9/19.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "Item1.h"
#import "VIPCenterModel.h"
#import "AFNetworkReachabilityManager.h"
#import "UIView+hr_Extension.h"
#import "HRThirdAlterViewVC.h"
#import "HRShareAlterViewVC.h"


#define kTableViewCellReuseID @"kTableViewCellReuseID"

#define kThirdLogin  @"thirdLogin"
#define kShare       @"share"

@interface Item1 ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *strings;
@end

@implementation Item1

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self netRequest];
    [self configUIAndData];
}

//配置UI 和 数据
-(void)configUIAndData
{
    //UI
    self.navigationItem.title = @"小集合";
    UITableView * tableView = [[UITableView alloc]initWithFrame:kScreenBounce];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewCellReuseID];
    //数据
    [self addCellTitle:@"图文混排"  string:@"WeiBoVC"];
    [self addCellTitle:@"第三方登录" string:kThirdLogin];
    [self addCellTitle:@"分享" string:kShare];
    
}
//示范一个网络请求
-(void)netRequest
{
    [HRHTTPTool text:kTextTaskDescription dataClass:[VIPCenterModel class] success:^(HRHTTPModel *responseObject) {
        HRLog(@"成功");
    } failure:^(HRHTTPModel *responseObject) {
    }];

}

#pragma mark - tableview delegate 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCellReuseID];
    cell.textLabel.text = self.titles[indexPath.row];
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    NSString * string = self.strings[indexPath.row];
    if ([self respondsToSelector:NSSelectorFromString(string)]) {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:NSSelectorFromString(string)];
        #pragma clang diagnostic pop
        return;
    }
    [HRFunctionTool pushViewController:[NSClassFromString(string) new] animated:true];
}

#pragma mark - 私有方法
//第三方登录
-(void)thirdLogin
{
    [HRThirdAlterViewVC show];
}
//分享
-(void)share
{
    [HRShareAlterViewVC show];
}

-(void)addCellTitle:(NSString *)title string:(NSString *)className
{
    [self.titles addObject:title];
    [self.strings addObject:className];
}

#pragma mark - click 点击事件

#pragma mark - 属性初始化
-(NSMutableArray *)titles
{
    if (_titles == nil) {
        _titles = @[].mutableCopy;
    }
    return _titles;
}

-(NSMutableArray *)strings
{
    if (_strings == nil) {
        _strings = @[].mutableCopy;
    }
    return _strings;
}

@end
