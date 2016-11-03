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
#import "MWPhotoBrowser.h"

@interface WeiBoVC ()<UITableViewDelegate,UITableViewDataSource,MWPhotoBrowserDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray * datas;
@property (assign ,nonatomic,getter=isReady) BOOL ready;
@property (nonatomic,strong) YYFPSLabel * FPSlabel;
@property (nonatomic,strong) NSMutableArray * photos;
@end

@implementation WeiBoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self readyForData];
    [self configUI];
}

-(void)configUI
{
    _FPSlabel = [[YYFPSLabel alloc]init];
    self.navigationItem.titleView = _FPSlabel;
}

-(void)readyForData
{
    self.progressView.hidden = false;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        self.datas = [WBTimelineItem localData];
        for (WBStatus * status in _datas) {
            //计算内容的高度
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
    WBStatus * status = _datas[indexPath.row];
    return status.contentHeight + status.retweetedStatus.contentHeight + 10;
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
    __weak typeof(self) selfWeak = self;
    WBCell * cell = [WBCell cell:tableView];
    cell.worldsClick = ^(NSString * worlds){
        
    };
    cell.pictureClick = ^(NSArray<NSURL *> * picURLs,NSInteger selectedIndex){
        selfWeak.photos = [NSMutableArray array];
        for (NSURL * url in picURLs) {
            [_photos addObject:[MWPhoto photoWithURL:url]];
        }
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        //不显示分享复制按钮
        browser.displayActionButton = NO;
        [browser setCurrentPhotoIndex:selectedIndex];
        // Present
        [self.navigationController pushViewController:browser animated:YES];
    };
    cell.status = _datas[indexPath.row];
    return cell;
}

#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}

#pragma mark - click 点击事件

-(void)click
{
    HRLog(@"点击了switch点击");
    _FPSlabel.hidden  = !_FPSlabel.hidden;
}

@end
