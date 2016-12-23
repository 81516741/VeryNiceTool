//
//  HRCubeRotateViewController.h
//  立体旋转
//
//  Created by ld on 16/12/2.
//  Copyright © 2016年 ld. All rights reserved.

#import <UIKit/UIKit.h>
@class CubeContainerView;

@interface HRCubeRotateViewController : UIViewController

-(instancetype)initWithViewControllers:(NSArray<UIViewController *> *)viewControllers;
-(void)updateUI:(NSArray<UIViewController *>*)controllers;
/**
 * 装立方体的容器view
 */
@property (nonatomic,strong) CubeContainerView * cubeContainerView;
/**
 * 装立方体的容器view的高度 默认 300
 */
@property (assign ,nonatomic) CGFloat cubeContainerViewHeight;

/**
 * 设置立方体的容器view距离顶部的距离
 */
@property (assign ,nonatomic) CGFloat cubeContainerViewY;
/**
 * 立方体容器里面的view 距立方体容器左右边距 默认 80
 */
@property (assign ,nonatomic) CGFloat cubeSubViewLRDistance;
/**
 * 立方体容器里面的view 距立方体容器上下边距 默认 30
 */
@property (assign ,nonatomic) CGFloat cubeSubViewTBDistance;
/**
 *  立柱整体绕x轴的旋转角度
 */
@property (assign ,nonatomic) CGFloat angleX;

/**
 * 所有的控制器
 */
@property (nonatomic,strong) NSArray * cubeViewControllers;
@end


@interface CubeContainerView : UIView
@property (assign ,nonatomic) BOOL isMoveEnd;
@property (nonatomic,copy) void(^touchMoveInSelf)(CGFloat offsetX);
@property (nonatomic,copy) void (^touchEnd)();
@property (nonatomic,copy) void (^invalidTimer)();

@end

@interface YY_TextWeakProxy : NSProxy

/**
 The proxy target.
 */
@property (nonatomic, weak, readonly) id target;

/**
 Creates a new weak proxy for target.
 
 @param target Target object.
 
 @return A new proxy object.
 */
- (instancetype)initWithTarget:(id)target;

/**
 Creates a new weak proxy for target.
 
 @param target Target object.
 
 @return A new proxy object.
 */
+ (instancetype)proxyWithTarget:(id)target;

@end



