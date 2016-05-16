//
//  LDPullMenuView.h
//  1.新浪微博
//
//  Created by mac on 15/10/13.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Block)();
@interface LDPullMenuView : UIView

/**显示menu到中间控件设置该vc*/
@property(nonatomic, strong) UIViewController  * contentVC;

/**显示menu到左右控件设置该vc*/
@property(nonatomic, strong) UIViewController  * contentLRVC;

@property(nonatomic, copy) Block  block;
+(instancetype)menu;
/**显示menu到中间控件*/
-(void)showMMenuFrom:(UIView *)from;
/**显示menu到右部控件*/
-(void)showRMenuFrom:(UIView *)from;
/**显示menu到左部控件*/
-(void)showLMenuFrom:(UIView *)from;

@end

//*****************************使用方法*********************
//-(void)rightBtnClick:(UIButton *)btn{
//    
//    LDPullMenuView * menu = [LDPullMenuView menu];
//    UIViewController * vc = [[UIViewController alloc]init];
//    vc.view.size = CGSizeMake(100, 100);
//    menu.contentVC = vc;
//    [menu showMMenuFrom:btn];
//}
