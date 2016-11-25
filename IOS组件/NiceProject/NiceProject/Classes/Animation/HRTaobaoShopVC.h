//
//  HRTaobaoShopVC.h
//  NiceProject
//
//  Created by ld on 16/11/25.
//  Copyright © 2016年 ld. All rights reserved.
//


#import "HRBaseVC.h"

@interface HRTaobaoShopVC : HRBaseVC

@end


@interface HRTaobaoSecondVC : UIViewController

@property (nonatomic,strong) HRTaobaoShopVC * presentingVC;
@end

@interface UIViewController (TaoBaoAnimation)
- (CATransform3D)firstTransform;

- (CATransform3D)secondTransform;
@end
