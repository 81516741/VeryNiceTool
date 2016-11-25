//
//  HRTransitonVC.m
//  NiceProject
//
//  Created by ld on 16/11/25.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRTransitonVC.h"
#import "UIView+hr_Transition.h"

@interface HRTransitonVC ()
@property (weak, nonatomic) IBOutlet UIView *view0;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UIView *view6;
@property (weak, nonatomic) IBOutlet UIView *view7;

@end

@implementation HRTransitonVC

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGFloat r = (arc4random()%10 + 1)/10.0;
    CGFloat g = (arc4random()%10 + 1)/10.0;
    CGFloat b = (arc4random()%10 + 1)/10.0;
    UIColor * color = [UIColor colorWithRed:r green:g blue:b alpha:1];
    
    _view0.backgroundColor = color;
    [_view0 addLayerTransitionWith:HRViewTransitionTypeFade subtype:HRViewTransitionSubtypeFromRight];
    
    _view1.backgroundColor = color;
    [_view1 addLayerTransitionWith:HRViewTransitionTypeCameraIrisHollowOpen subtype:HRViewTransitionSubtypeFromRight];
    
    _view2.backgroundColor = color;
    [_view2 addLayerTransitionWith:HRViewTransitionTypePush subtype:HRViewTransitionSubtypeFromRight];
    
    _view3.backgroundColor = color;
    [_view3 addLayerTransitionWith:HRViewTransitionTypeReveal subtype:HRViewTransitionSubtypeFromRight];
    
    _view4.backgroundColor = color;
    [_view4 addLayerTransitionWith:HRViewTransitionTypeCube subtype:HRViewTransitionSubtypeFromRight];
    
    _view5.backgroundColor = color;
    [_view5 addLayerTransitionWith:HRViewTransitionTypeSuckEffect subtype:HRViewTransitionSubtypeFromRight];
    
    _view6.backgroundColor = color;
    [_view6 addLayerTransitionWith:HRViewTransitionTypeOglFlip subtype:HRViewTransitionSubtypeFromRight];
    
    _view7.backgroundColor = color;
    [_view7 addLayerTransitionWith:HRViewTransitionTypeRippleEffect subtype:HRViewTransitionSubtypeFromRight];
}
@end
