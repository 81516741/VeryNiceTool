//
//  LDpresentationController.m
//  15.自定义uipresentationcontrol
//
//  Created by mac on 15/11/18.
//  Copyright © 2015年 LD. All rights reserved.
//

#import "LDpresentationController.h"

//LDpresentationController 这个是自定义的presentationController，自从ios8开始
//所有modal出来的控制器，都由它管理，包括PopoverView-->这个是在ipad里面用的
@implementation LDpresentationController

//当没有自定义动画时，这个可以控制被modal出来的view的大小
//- (CGRect)frameOfPresentedViewInContainerView{

//    return CGRectInset(self.containerView.bounds, 50, 50);

//}


/**即将开始展示*/
//注意这里需要手动将view添加上去，frame可以所以设置
- (void)presentationTransitionWillBegin{
    
    self.presentedView.frame = self.containerView.bounds;

    [self.containerView addSubview:self.presentedView];
    
}
/**展示完毕*/
- (void)presentationTransitionDidEnd:(BOOL)completed{
    
}
/**即将dimiss*/
- (void)dismissalTransitionWillBegin{
    
}
/**dismiss完毕*/
//注意这里需要手动将view移除
- (void)dismissalTransitionDidEnd:(BOOL)completed{
    
    [self.presentedView removeFromSuperview];
}

@end
