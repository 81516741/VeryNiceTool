//
//  HRTipVC.h
//  DriveCloudPhone
//
//  Created by yh on 16/5/21.
//  Copyright © 2016年 yh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRTipVC : UIViewController

+(instancetype)initInVC:(UIViewController *)desVC;
@property (nonatomic,copy) NSString * message;

-(void)hideView;
-(void)showWithhander:(void (^)(HRTipVC * tipVC))hander;

@end
