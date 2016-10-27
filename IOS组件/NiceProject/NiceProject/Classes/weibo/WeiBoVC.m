//
//  WeiBoVC.m
//  图文混排
//
//  Created by ld on 16/10/26.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "WeiBoVC.h"
#import "WBModel.h"
#import "WBCell.h"
#import "YYFPSLabel.h"

@interface WeiBoVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray * datas;
@property (assign ,nonatomic,getter=isReady) BOOL ready;


@end

@implementation WeiBoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self readyForData];
    [self configUI];
}

-(void)configUI
{
    YYFPSLabel * label = [[YYFPSLabel alloc]init];
    self.navigationItem.titleView = label;
}

-(void)readyForData
{
    self.progressView.hidden = false;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.datas = [WBTimelineItem localData];
        for (WBStatus * status in _datas) {
            [status textHeight];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.ready = true;
            [self.tableView reloadData];
            self.progressView.hidden = true;
        });
    });
}

#pragma mark - tableview delegate 代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_datas[indexPath.row] textHeight];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isReady) {
        return _datas.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBCell * cell = [WBCell cell:tableView];
    cell.status = _datas[indexPath.row];
    return cell;
}

#pragma mark - click 点击事件

-(void)click
{
    HRLog(@"点击了switch点击");
}

@end
