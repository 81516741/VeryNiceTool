//
//  UIView+HRTransition.h
//  转场动画
//
//  Created by ld on 16/11/25.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HRLayerTransitionType) {
    HRViewTransitionTypeFade,                   // 淡化效果
    HRViewTransitionTypeMoveIn,                 // 推入效果
    HRViewTransitionTypePush,                   // 移出效果
    HRViewTransitionTypeReveal,                 // 退出效果
    HRViewTransitionTypeCube,                   // 3D 效果
    HRViewTransitionTypeSuckEffect,             // 吮吸效果
    HRViewTransitionTypeOglFlip,                // 翻转效果
    HRViewTransitionTypeRippleEffect,           // 波纹效果
    HRViewTransitionTypePageCurl,               // 翻页效果
    HRViewTransitionTypePageUncurl,             // 反翻页效果
    HRViewTransitionTypeCameraIrisHollowOpen,   // 开镜头效果
    HRViewTransitionTypeCameraIrisHollowClose,  // 关镜头效果
};

typedef NS_ENUM(NSUInteger, HRLayerTransitionSubtype) {
    HRViewTransitionSubtypeFromRight,
    HRViewTransitionSubtypeFromLeft,
    HRViewTransitionSubtypeFromBottom,
    HRViewTransitionSubtypeFromTop,
};

@interface UIView (hr_Transition)

- (void)addLayerTransitionWith:(HRLayerTransitionType)type subtype:(HRLayerTransitionSubtype)subtype;

- (void)addViewAnimationTransition:(UIViewAnimationTransition)transition AnimationCurve:(UIViewAnimationCurve)curve;

@end
