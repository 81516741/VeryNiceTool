//
//  ViewController.h
//  导航控制器
//
//  Created by ld on 16/9/19.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HRObject.h"
#import "HRFunctionTool.h"
#import "HRHTTPTool.h"
#import "HRHTTPModel.h"
#import "HRConst.h"
#import "HRThirdLoginTool.h"

@interface HRBaseVC : UIViewController

@property (nonatomic,strong) UIView * progressView;

-(void)click;
@end

