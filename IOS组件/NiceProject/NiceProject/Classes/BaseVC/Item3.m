//
//  Item3.m
//  导航控制器
//
//  Created by ld on 16/9/20.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "Item3.h"
#import "YYImage.h"
#import "HRImageDownLoader.h"
@interface Item3 ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerCons;
@property (nonatomic,strong) YYImageDecoder * decoder;
@end

@implementation Item3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its
    _decoder = [[YYImageDecoder alloc] initWithScale:[UIScreen mainScreen].scale];
    [[HRImageDownLoader share] downLoadImageWithUrl:@"http://b.zol-img.com.cn/desk/bizhi/image/2/960x600/1366358210590.jpg" progress:^(NSData * data, BOOL complete) {
        [_decoder updateData:data final:complete];
        if (_decoder.frameCount > 0) {
            UIImage * image = [_decoder frameAtIndex:0 decodeForDisplay:YES].image;
            // progressive display...
            self.imageView.image = image;
            HRLog(@"展示...");
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [UITableViewCell new];
    cell.textLabel.text = @"我要找bug";
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.centerCons.constant  = 150;
    [UIView animateWithDuration:1 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    _decoder = [[YYImageDecoder alloc] initWithScale:[UIScreen mainScreen].scale];
    [[HRImageDownLoader share] clearImageCache];
    [[HRImageDownLoader share] downLoadImageWithUrl:@"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1208/23/c1/13132349_1345701771868.jpg" progress:^(NSData * data, BOOL complete) {
        [_decoder updateData:data final:complete];
        if (_decoder.frameCount > 0) {
            UIImage * image = [_decoder frameAtIndex:0 decodeForDisplay:YES].image;
            // progressive display...
            self.imageView.image = image;
            HRLog(@"展示...");
        }
    }];
}

@end
