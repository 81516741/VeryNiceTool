//
//  LDPullMenuView.m
//  1.新浪微博
//
//  Created by mac on 15/10/13.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDPullMenuView.h"

@interface LDPullMenuView()

@property(nonatomic, strong) UIImageView  * contentView;

@property(nonatomic, strong) UIImageView  * contentLRView;


@end

@implementation LDPullMenuView

//******************************黑色背景图片的Mview*******************
-(UIImageView *)contentView{
    if (_contentView == nil) {
        
        _contentView = [[UIImageView alloc]init];
        _contentView.image = [UIImage imageNamed:@"popover_background"];
        _contentView.userInteractionEnabled = YES;
        [self addSubview:_contentView];
        
    }
    
    return _contentView;
}
//******************************黑色背景图片的Rview*******************
-(UIImageView *)contentLRView{
    if (_contentLRView == nil) {
        
        _contentLRView = [[UIImageView alloc]init];
        _contentLRView.backgroundColor = [UIColor blackColor];
        _contentLRView.userInteractionEnabled = YES;
        [self addSubview:_contentLRView];
        
    }
    
    return _contentLRView;
}



//********************将menu展示在from下面*******************
//这个不抽了，有很多学习的记录
-(void)showMMenuFrom:(UIView *)from{
    
    UIWindow * widow = [[UIApplication sharedApplication].windows lastObject];
    [widow addSubview:self];
    
    //位置在这里调整最合适，显示时才调整，视频里面的方法是设置vc就调整了如果设置vc时，并未设置VC的view 的尺寸是会有问题的，做判断是因为，如果没有vc就不用执行这个了
    if (self.contentVC) {
        
        CGFloat width = self.contentVC.view.width;
        CGFloat height = self.contentVC.view.height;
        self.contentView.width = width + 20;
        
        //为了做动画效果，渐渐出来
        [UIView animateWithDuration:0.5 animations:^{
            
            self.contentView.height = height +25 ;
        }];

        self.contentVC.view.frame = CGRectMake(10, 14, width, height);
        
        
#warning 重点啊，重点啊,                                                       **1步** 后self.contentVC.view.width 变成了220 220=100 + 120）这个值正好是原理啊的width加上self.contentView.width，**2步** 后变成了225，为什么？干脆像上面那么些就没问题了
//        self.contentView.width = self.contentVC.view.width + 20;//1步
//        self.contentView.height = self.contentVC.view.height +25 ;//2步
//        self.contentVC.view.frame = CGRectMake(10, 14, self.contentView.width - 20, self.contentView.height - 25);
        

    }
 
    //调整黑色菜单在window坐标系下相对于from的位置---这时将所有的坐标转到window下，就比较合适了(from.superView convertRect:from.frame toView:widow)也ok
#warning 这里卡了半天，因为后面的toView弄错了，from去了；
    CGRect newFromFrame = [from convertRect:from.bounds toView:widow];
    self.contentView.centerX = newFromFrame.origin.x + newFromFrame.size.width*0.5;
    self.contentView.y = CGRectGetMaxY(newFromFrame) ;
}

//********************右边展示menu*******************
-(void)showRMenuFrom:(UIView *)from{
    
    [self showMenuWithImageView:self.contentLRView desView:from];
    self.contentLRView.x = CGRectGetMaxX(from.frame) - self.contentLRView.width;

}

//********************左边展示menu*******************
-(void)showLMenuFrom:(UIView *)from{
    
    [self showMenuWithImageView:self.contentLRView desView:from];
    self.contentLRView.x = from.x;

}

//展示menu抽出的方法
-(void)showMenuWithImageView:(UIImageView *)contentLRView desView:(UIView *)from {
    
    UIWindow * widow = [[UIApplication sharedApplication].windows lastObject];
    [widow addSubview:self];
    
    if (self.contentLRVC) {
        
        CGFloat width = self.contentLRVC.view.width;
        CGFloat height = self.contentLRVC.view.height;
        contentLRView.width = width + 20;
        [UIView animateWithDuration:0.5 animations:^{
            
            contentLRView.height = height +25 ;
        }];
        
        self.contentLRVC.view.frame = CGRectMake(10, 14, width, height);
        
    }
    
    CGRect newFromFrame = [from convertRect:from.bounds toView:widow];
    
    contentLRView.x = from.x;
    
    contentLRView.y = CGRectGetMaxY(newFromFrame) ;
}


//************控制的view加到黑色菜单里面去，位置显示时调整*******************

-(void)setContentVC:(UIViewController *)contentVC{
    
    _contentVC = contentVC;
    
    [self.contentView addSubview:contentVC.view];
    

    
    
}

-(void)setContentLRVC:(UIViewController *)contentLRVC{
    
    _contentLRVC = contentLRVC;
    [self.contentLRView addSubview:contentLRVC.view];
    
}

//********************这个self本身就是后面的透明板，防止乱点*******************
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}



+(instancetype)menu{
    
    return [[self alloc]init];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (self.block) {
        self.block();
    }
    
    //为了做动画效果，渐渐消失
    [UIView animateWithDuration:0.5 animations:^{
        self.contentView.height = 0;
        self.contentLRView.height = 0;
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });

    
}

@end
