//
//  ImageListView.m
//  DriveCloudPhone
//
//  Created by yh on 16/8/25.
//  Copyright © 2016年 yh. All rights reserved.
//

#import "ImageListView.h"
#define COL 4
#define ITEMWH (([UIScreen mainScreen].bounds.size.width - (COL + 1) * ITEMMARGIN)/COL)
#define ITEMMARGIN 12

@interface ImageListView()
@property (nonatomic,weak) UIView * addView;
@property (nonatomic,weak) UILabel * countLable;
@end

@implementation ImageListView

-(void)awakeFromNib
{
    [self addMyView];
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addMyView];
    }
    return self;
}

-(void)addMyView
{
    self.maxPicCount = self.maxPicCount == 0 ? 5 : self.maxPicCount;
    UIView * addMyView = [[UIView alloc]init];
    self.addView = addMyView;
    [self addSubview:addMyView];
    addMyView.layer.borderWidth = 1;
    addMyView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    addMyView.frame = CGRectMake(ITEMMARGIN,ITEMMARGIN, ITEMWH, ITEMWH);
    
    //添加image
    UIImageView * addImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"add"]];
    addImage.frame = CGRectMake(ITEMWH * 0.3,ITEMWH * 0.05, ITEMWH * 0.4, ITEMWH * 0.4);
    [addMyView addSubview:addImage];
    
    //添加文字
    CGFloat lableH = 15;
    UILabel * lableTop = [[UILabel alloc]init];
    lableTop.text = @"请上传凭证";
    lableTop.frame = CGRectMake(0, ITEMWH * 0.5, ITEMWH, lableH);
    lableTop.textAlignment = NSTextAlignmentCenter;
    lableTop.font = [UIFont systemFontOfSize:12];
    lableTop.textColor = [UIColor lightGrayColor];
    [addMyView addSubview:lableTop];
    
    UILabel * lableBottom = [[UILabel alloc]init];
    self.countLable = lableBottom;
    [self setLabelCount:self.maxPicCount];
    lableBottom.frame = CGRectMake(0, ITEMWH * 0.5 + lableH, ITEMWH, lableH);
    lableBottom.textAlignment = NSTextAlignmentCenter;
    lableBottom.font = [UIFont systemFontOfSize:12];
    lableBottom.textColor = [UIColor lightGrayColor];
    [addMyView addSubview:lableBottom];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addImageClick)];
    [addMyView addGestureRecognizer:tap];
    
}

-(void)setLabelCount:(NSInteger)count
{
   self.countLable.text = [NSString stringWithFormat:@"最多(%ld)",count];
}

-(void)setImages:(NSMutableArray *)images
{
    for (UIView * subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            [subView removeFromSuperview];
        }
    }
    _images = images;
    NSInteger row = 0;
    NSInteger col = 0;
    for (int i = 0; i < images.count + 1; i ++)
    {
        row = i /COL;
        col = i % COL;
        
        if (i == images.count) {
            self.addView.frame = CGRectMake(col * (ITEMMARGIN + ITEMWH) + ITEMMARGIN, row * (ITEMMARGIN + ITEMWH), ITEMWH, ITEMWH);
            self.addView.hidden = false;
            break;
        }
        //图片
        UIButton * btn = [[UIButton alloc]init];
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btn.tag = i;
        btn.frame = CGRectMake(col * (ITEMMARGIN + ITEMWH) + ITEMMARGIN, row * (ITEMMARGIN + ITEMWH), ITEMWH, ITEMWH);
        [btn setImage:images[i] forState:UIControlStateNormal];
        btn.contentMode = UIViewContentModeScaleAspectFill;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        //图片坐上角的删除
        UIImageView * imageDele = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"delete"]];
        imageDele.frame = CGRectMake(ITEMWH - 7.5, -7.5, 15, 15);
        [btn addSubview:imageDele];
        [self addSubview:btn];

    }
    if (images.count >= self.maxPicCount)
    {
        self.addView.hidden = true;
    }
    
    
}

-(void)btnClick:(UIButton *)btn
{
    [_images removeObjectAtIndex:btn.tag];
    self.images = _images;
}

-(void)addImageClick
{
    if (self.addImageBtnClick) {
        self.addImageBtnClick();
    }
}


@end
