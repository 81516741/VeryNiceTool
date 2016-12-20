//
//  HRCubeRotateViewController.m
//  立体旋转
//
//  Created by ld on 16/12/2.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRCubeRotateViewController.h"
#import <objc/runtime.h>

#define kStandAngle (M_PI * 2/self.cubeViewControllers.count)

static CGFloat animationInterval = 0.04;//越小转动越快
static CGFloat animationDuration = 1; //2次转动的间隔时间

@interface HRCubeRotateViewController ()

//是否是从右到左转
@property (assign ,nonatomic) BOOL rotationR2L;
//单次转动的角度和
@property (assign ,nonatomic) CGFloat moveAngle;
//动画的2个定时器
@property (nonatomic,strong) NSTimer * tickTimer;
@property (nonatomic,strong) NSTimer * seriesTimer;
//转了多少次
@property (assign ,nonatomic) NSInteger step;
//转了多少角度
@property (assign ,nonatomic) CGFloat angle;
@end

@implementation HRCubeRotateViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configBaseParam];
    }
    return self;
}
-(instancetype)initWithViewControllers:(NSArray<UIViewController *> *)viewControllers
{
    self = [super init];
    if (self) {
        self.cubeViewControllers = viewControllers;
        [self configBaseParam];
    }
    return self;
}

-(void)configBaseParam
{
    self.cubeSubViewLRDistance = 80;
    self.cubeSubViewTBDistance = 60;
    self.cubeContainerViewHeight = 360;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI:self.cubeViewControllers];
}

-(void)updateUI:(NSArray<UIViewController *>*)controllers
{
    [_cubeContainerView removeFromSuperview];
    _cubeContainerView = nil;
    _cubeViewControllers = controllers;
    if (_cubeViewControllers.count == 0) {
        return;
    }
    for (int i = 0; i < _cubeViewControllers.count; i++) {
        UIViewController * vc = controllers[i];
        vc.view.frame = CGRectMake(0, 0, self.cubeContainerView.bounds.size.width - 2 * self.cubeSubViewLRDistance, self.cubeContainerView.bounds.size.height - 2 * self.cubeSubViewTBDistance);
        vc.view.center = CGPointMake(self.cubeContainerView.bounds.size.width * 0.5, self.cubeContainerView.bounds.size.height * 0.5);
        vc.view.userInteractionEnabled = true;
        vc.automaticallyAdjustsScrollViewInsets = false;
        [self.cubeContainerView addSubview:vc.view];
        [self addChildViewController:vc];
    }
    UIViewController * vc0 = controllers[0];
    UIViewController * vc1 = controllers[1];
    [self.cubeContainerView bringSubviewToFront:vc0.view];
    [self.cubeContainerView bringSubviewToFront:vc1.view];
    [self setCubeRotateAngle:0.01];
    self.rotationR2L = true;
    [self tickAnimation];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.clipsToBounds = true;
    [self.view addSubview:_cubeContainerView];
    if (self.navigationController && 0 == self.cubeContainerViewY) {
        self.cubeContainerViewY = 64;
    }else{
        self.cubeContainerViewY = _cubeContainerViewY;
    }
    [self eventHandle];
}

-(void)eventHandle
{
    __weak typeof(self) selfWeak = self;
    CGFloat standAngel = kStandAngle;
    self.cubeContainerView.touchMoveInSelf = ^(CGFloat angle){
        [selfWeak invalidateAllTimer];
        selfWeak.angle += angle;
        if (selfWeak.angle > (selfWeak.step+1) * standAngel) {
            selfWeak.step ++;
        }
        if (selfWeak.angle < selfWeak.step * standAngel){
            selfWeak.step --;
        }
        [selfWeak setCubeRotateAngle:selfWeak.angle];
        selfWeak.moveAngle += angle;
    };
    self.cubeContainerView.touchEnd = ^{
        [selfWeak invalidateAllTimer];
        if (selfWeak.moveAngle >= 0) {
            if (selfWeak.moveAngle > standAngel * 0.5) {//右->左 转
                selfWeak.rotationR2L = true;
            }else{
                selfWeak.rotationR2L = false;
            }
        }else{
            if (selfWeak.moveAngle < 0) {
                if (selfWeak.moveAngle > -standAngel * 0.5) {//右->左 转
                    selfWeak.rotationR2L = true;
                }else{
                    selfWeak.rotationR2L = false;
                }
            }
        }
        
        selfWeak.moveAngle = 0;
        [selfWeak seriesAnimation];
        
    };
    
    self.cubeContainerView.invalidTimer = ^{
        [selfWeak invalidateAllTimer];
        [selfWeak tickAnimation];
    };
    
}

-(void)setCubeContainerViewY:(CGFloat)y
{
    _cubeContainerViewY = y;
    CGRect frame = self.cubeContainerView.frame;
    frame.origin.y = y;
    self.cubeContainerView.frame = frame;
}

-(void)setCubeContainerViewHeight:(CGFloat)cubeContainerViewHeight
{
    _cubeContainerViewHeight = cubeContainerViewHeight;
    CGRect frame = self.cubeContainerView.frame;
    frame.size.height = cubeContainerViewHeight;
    self.cubeContainerView.frame = frame;
}

-(CubeContainerView *)cubeContainerView
{
    if (_cubeContainerView == nil) {
        _cubeContainerView = [[CubeContainerView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, _cubeContainerViewHeight)];
        _cubeContainerView.backgroundColor = [UIColor blueColor];
    }
    return _cubeContainerView;
}

#pragma mark - animation 动画
-(void)tickAnimation
{
    [_seriesTimer invalidate];
    _seriesTimer = nil;
    _tickTimer = [NSTimer timerWithTimeInterval:animationDuration target:[YY_TextWeakProxy proxyWithTarget:self] selector:@selector(seriesAnimation) userInfo:nil repeats:true];
    [[NSRunLoop currentRunLoop]addTimer:_tickTimer forMode:NSDefaultRunLoopMode];
}

-(void)seriesAnimation
{
    [self seriesAnimationWithInterval:animationInterval];
}

-(void)seriesAnimationWithInterval:(CGFloat)interval
{
    [_tickTimer invalidate];
    _tickTimer = nil;
    if (_rotationR2L) {
        _seriesTimer = [NSTimer timerWithTimeInterval:interval target:[YY_TextWeakProxy proxyWithTarget:self] selector:@selector(animationR2L:) userInfo:nil repeats:true];
    }else{
        _seriesTimer = [NSTimer timerWithTimeInterval:interval target:[YY_TextWeakProxy proxyWithTarget:self] selector:@selector(animationL2R:) userInfo:nil repeats:true];
    }
    [[NSRunLoop currentRunLoop]addTimer:_seriesTimer forMode:NSDefaultRunLoopMode];
}

-(void)animationL2R:(NSTimer *)seriesTimer
{
    _angle -= 0.04;
    if (_angle < _step * kStandAngle) {
        [seriesTimer invalidate];
        seriesTimer = nil;
        _angle = _step * kStandAngle;
        [self setCubeRotateAngle:_angle];
        self.rotationR2L = true;
        [self tickAnimation];
        [self resetViewPosition];
        return;
    }
    [self setCubeRotateAngle:_angle];
}
-(void)animationR2L:(NSTimer *)seriesTimer
{
    _angle += 0.04;
    if (_angle > (_step+1) * kStandAngle) {
        [seriesTimer invalidate];
        seriesTimer = nil;
        _step ++;
        _angle = _step * kStandAngle;
        [self setCubeRotateAngle:_angle];
        [self tickAnimation];
        [self resetViewPosition];
        return;
    }
    [self setCubeRotateAngle:_angle];
}
-(void)resetViewPosition
{
    NSInteger currentViewIndex = 0;
    NSInteger nextViewIndex = 0;
    NSInteger preViewIndex = 0;
    if (_step >= 0) {
        currentViewIndex = _step % _cubeViewControllers.count;
    }else{
        currentViewIndex =_cubeViewControllers.count - ABS(_step) % _cubeViewControllers.count;
    }
    nextViewIndex = currentViewIndex + 1;
    preViewIndex = currentViewIndex - 1;
    if (nextViewIndex >= _cubeViewControllers.count) {
        nextViewIndex = 0;
    }
    if (preViewIndex < 0) {
        preViewIndex = _cubeViewControllers.count - 1;
    }
    
    UIViewController * vc = _cubeViewControllers[currentViewIndex];
    UIViewController * vcNext = _cubeViewControllers[nextViewIndex];
    UIViewController * vcPre = _cubeViewControllers[preViewIndex];
    
    [_cubeContainerView bringSubviewToFront:vcNext.view];
    [_cubeContainerView bringSubviewToFront:vcPre.view];
    [_cubeContainerView bringSubviewToFront:vc.view];
}
- (void)setCubeRotateAngle:(float)angle
{
    CGFloat disZ = 1000;
    CGFloat length = self.cubeContainerView.bounds.size.width - 2 * self.cubeSubViewLRDistance;
    CGFloat multiParam = cosf(M_PI_2 - (M_PI * 2/self.cubeViewControllers.count));
    CATransform3D move = CATransform3DMakeTranslation(0, 0, length * multiParam);
    CATransform3D back = CATransform3DMakeTranslation(0, 0, -length * multiParam);
    for (int i = 0; i < self.cubeViewControllers.count; i ++)
    {
        UIViewController * vc = self.cubeViewControllers[i];
        CATransform3D rotateY = CATransform3DMakeRotation(kStandAngle * i - angle, 0, 1, 0);
        CATransform3D rotateX = CATransform3DMakeRotation(-M_PI_4 * 0.4, 1, 0, 0);
        CATransform3D mat =CATransform3DConcat(CATransform3DConcat(CATransform3DConcat(move, rotateY), rotateX), back);
        vc.view.layer.transform = [self CATransform3DPerspect:mat center:CGPointZero disZ:disZ];
    }
    
}


-(CATransform3D)CATransform3DMakePerspective:(CGPoint) center disZ:(CGFloat) disZ
{
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}

-(CATransform3D)CATransform3DPerspect:(CATransform3D) t center:(CGPoint) center disZ:(CGFloat) disZ
{
    return CATransform3DConcat(t, [self CATransform3DMakePerspective:center disZ:disZ]);
}

-(void)invalidateAllTimer
{
    [self.seriesTimer invalidate];
    self.seriesTimer = nil;
    
    [self.tickTimer invalidate];
    self.tickTimer = nil;
}
-(void)dealloc
{
    [self invalidateAllTimer];
}
@end



@implementation CubeContainerView

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    CGPoint pointPre = [touch previousLocationInView:self];
    CGFloat offset = pointPre.x - point.x;
    _isMoveEnd = true;
    if (self.touchMoveInSelf) {
        self.touchMoveInSelf(offset/[UIScreen mainScreen].bounds.size.width);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    if (!_isMoveEnd) {
        return;
    }
    if (self.touchEnd) {
        _isMoveEnd = false;
        self.touchEnd();
    }
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.invalidTimer) {
        self.invalidTimer();
    }
    if (point.y > 0 && point.y < self.bounds.size.height)
    {
        return true;
    }
    return false;
}

@end


@implementation YY_TextWeakProxy

- (instancetype)initWithTarget:(id)target {
    _target = target;
    return self;
}

+ (instancetype)proxyWithTarget:(id)target {
    return [[YY_TextWeakProxy alloc] initWithTarget:target];
}

- (id)forwardingTargetForSelector:(SEL)selector {
    return _target;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    void *null = NULL;
    [invocation setReturnValue:&null];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [_target respondsToSelector:aSelector];
}

- (BOOL)isEqual:(id)object {
    return [_target isEqual:object];
}

- (NSUInteger)hash {
    return [_target hash];
}

- (Class)superclass {
    return [_target superclass];
}

- (Class)class {
    return [_target class];
}

- (BOOL)isKindOfClass:(Class)aClass {
    return [_target isKindOfClass:aClass];
}

- (BOOL)isMemberOfClass:(Class)aClass {
    return [_target isMemberOfClass:aClass];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    return [_target conformsToProtocol:aProtocol];
}

- (BOOL)isProxy {
    return YES;
}

- (NSString *)description {
    return [_target description];
}

- (NSString *)debugDescription {
    return [_target debugDescription];
}

@end
