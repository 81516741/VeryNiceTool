//
//  CubeRotateVC.m
//  立体旋转
//
//  Created by ld on 16/12/2.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "CubeRotateVC.h"

@interface CubeRotateVC ()
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UIImageView *image4;
@property (weak, nonatomic) IBOutlet UIImageView *image5;
@property (weak, nonatomic) IBOutlet UIImageView *image6;
@property (assign ,nonatomic) NSInteger step;
@property (assign ,nonatomic) CGFloat angle;

@end

@implementation CubeRotateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _angle = 0;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self tickAnimation];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setCubeFlipAngle:0.001];
}


-(void)tickAnimation
{
    __weak typeof(self) selfWeak = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW , (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [NSTimer scheduledTimerWithTimeInterval:0.06 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [selfWeak animation:timer];
        }];
    });
}

-(void)animation:(NSTimer *)timer
{
    _angle += 0.04;
    if (_angle > (_step+1) * (M_PI/3)) {
        [timer invalidate];
        timer = nil;
        _step ++;
        _angle = _step * (M_PI/3);
        [self setCubeFlipAngle:_angle];
        [self tickAnimation];
        return;
    }
    [self setCubeFlipAngle:_angle];
}

- (void)setCubeFlipAngle:(float)angle
{
    CGFloat length = [UIScreen mainScreen].bounds.size.width - 160;
    CATransform3D move = CATransform3DMakeTranslation(0, 0, length * 0.866f );//图片长度 * cos30°
    CATransform3D back = CATransform3DMakeTranslation(0, 0, -length * 0.866f );
    
    CATransform3D rotate1 = CATransform3DMakeRotation(-angle, 0, 1, 0);
    CATransform3D rotate2 = CATransform3DMakeRotation(M_PI/3-angle, 0, 1, 0);
    CATransform3D rotate3 = CATransform3DMakeRotation(M_PI/3*2 -angle, 0, 1, 0);
    CATransform3D rotate4 = CATransform3DMakeRotation(M_PI/3*3-angle, 0, 1, 0);
    CATransform3D rotate5 = CATransform3DMakeRotation(M_PI/3*4-angle, 0, 1, 0);
    CATransform3D rotate6 = CATransform3DMakeRotation(M_PI/3*5-angle, 0, 1, 0);
    
    
    CATransform3D rotate = CATransform3DMakeRotation(-M_PI/10, 1, 0, 0);
    
    CATransform3D mat1 = CATransform3DConcat(CATransform3DConcat(CATransform3DConcat(move, rotate1), back),rotate);
    CATransform3D mat2 = CATransform3DConcat(CATransform3DConcat(CATransform3DConcat(move, rotate2), back),rotate);
    CATransform3D mat3 = CATransform3DConcat(CATransform3DConcat(CATransform3DConcat(move, rotate3), back),rotate);
    CATransform3D mat4 = CATransform3DConcat(CATransform3DConcat(CATransform3DConcat(move, rotate4), back),rotate);
    CATransform3D mat5 = CATransform3DConcat(CATransform3DConcat(CATransform3DConcat(move, rotate5), back),rotate);
    CATransform3D mat6 = CATransform3DConcat(CATransform3DConcat(CATransform3DConcat(move, rotate6), back),rotate);
    
    CGFloat disZ = 1000;
    _image1.layer.transform = CATransform3DPerspect(mat1, CGPointZero, disZ);
    _image2.layer.transform = CATransform3DPerspect(mat2, CGPointZero, disZ);
    _image3.layer.transform = CATransform3DPerspect(mat3, CGPointZero, disZ);
    _image4.layer.transform = CATransform3DPerspect(mat4, CGPointZero, disZ);
    _image5.layer.transform = CATransform3DPerspect(mat5, CGPointZero, disZ);
    _image6.layer.transform = CATransform3DPerspect(mat6, CGPointZero, disZ);
}


CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ)
{
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}

CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ)
{
    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));
}

@end
