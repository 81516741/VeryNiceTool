//
//  CubeRotateApplyVC.m
//  NiceProject
//
//  Created by ld on 16/12/19.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "CubeRotateApplyVC.h"
#import "Cube0.h"
#import "Cube1.h"
#import "Cube2.h"
#import "Cube3.h"
#import "Cube4.h"
#import "Cube5.h"
#import "HRObject.h"
@interface CubeRotateApplyVC ()

@end

@implementation CubeRotateApplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cubeSubViewLRDistance = 80;
    self.cubeSubViewTBDistance = 60;
    self.cubeContainerViewHeight = 360;
    self.cubeContainerViewY = 64;
    self.angleX = 0;
    [self updateUI:@[[Cube0 new],[Cube1 new],[Cube2 new],[Cube3 new],[Cube4 new],[Cube5 new]]];
    [HRObject share].rootNC.canDragBack = false;
}
-(void)dealloc
{
    [HRObject share].rootNC.canDragBack = true;
}

@end
