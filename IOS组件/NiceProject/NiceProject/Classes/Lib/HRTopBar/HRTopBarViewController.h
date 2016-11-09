//
//  HRTopBarViewController.h
//  顶部tabbar的封装
//
//  Created by ld on 16/11/7.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRTopBarViewController : UIViewController

-(instancetype)initWithControllers:(NSArray<UIViewController *> *)viewControllers titles:(NSArray<NSString *> *)titles;
/**
 * topbar是否是在导航条上
 */
@property (assign ,nonatomic) BOOL isNaviTopBar;
/**
 * 用来调整顶部起始位置，可以自行调整至最佳
 * 有导航条 可以设置 64  无导航条可以不设置
 */
@property (assign ,nonatomic) CGFloat topOffsetY;
/**
 *  顶部显示内容的容器高度 默认42
 */
@property (assign ,nonatomic) CGFloat topScrollerViewHeight;
/**
 *  顶部显示内容容器的背景色 默认白色
 */
@property (nonatomic,strong) UIColor * topScrollerViewColor;
/**
 *  指示条的高度 默认2
 */
@property (assign ,nonatomic) CGFloat topLineHeight;
/**
 *  指示条的颜色 默认淡蓝色
 */
@property (nonatomic,strong)  UIColor * topLineColor;
/**
 * 文字未选中的颜色  默认浅灰
 */
@property (nonatomic,strong) UIColor * titleNormalColor;
/**
 * 文字选中的颜色  默认淡蓝色
 */
@property (nonatomic,strong) UIColor * titleSelectedColor;
/**
 * 文字的字体大小  默认16
 */
@property (assign ,nonatomic) NSInteger titleFontSize;

/**
 * 默认4
 * 目前只支持 (maxCount >= 子控制器的数目) 的情况
 */
@property (assign ,nonatomic) NSInteger maxCount;
/**
 *  是否可以滑动       默认YES
 */
@property (assign ,nonatomic) BOOL canScroll;
/**
 *  是否可有回弹效果    默认YES
 */
@property (assign ,nonatomic) BOOL canBounce;


@end
