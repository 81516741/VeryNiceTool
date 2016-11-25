//
//  HRTaobaoShopVC.m
//  NiceProject
//
//  Created by ld on 16/11/25.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRTaobaoShopVC.h"
#import "HRObject.h"

@interface HRTaobaoShopVC ()

@end

@implementation HRTaobaoShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

}
- (IBAction)buyClick:(UIButton *)sender
{

    [UIView animateWithDuration:0.25 animations:^{
        [self.view.layer setTransform:[self firstTransform]];
    } completion:^(BOOL finished) {
        HRTaobaoSecondVC * vc = [HRTaobaoSecondVC new];
        vc.presentingVC = self;
        [self presentViewController:vc animated:true completion:nil];
        [UIView animateWithDuration:0.25 animations:^{
            [self.view.layer setTransform:[self secondTransform]];
        }];
    }];
    
}

@end




@interface HRTaobaoSecondVC()
@property (nonatomic,strong) UIImageView * imageView;
@end

@implementation HRTaobaoSecondVC

-(void)viewDidLoad
{
    [super viewDidLoad];
    UIButton * bButton = [[UIButton alloc]initWithFrame:[UIScreen mainScreen].bounds];
    bButton.backgroundColor  = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [bButton addTarget:self action:@selector(bViewClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bButton];
    
    _imageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height *2/3)];
    _imageView.image = [UIImage imageNamed:@"商品选项"];
    [self.view addSubview:_imageView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.25 animations:^{
        _imageView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height * 1/3, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height *2/3);
    }];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}
- (void)bViewClick
{
    [UIView animateWithDuration:0.25 animations:^{
        _imageView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height *2/3);
        [self.presentingVC.view.layer setTransform:[self firstTransform]];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            [self dismissViewControllerAnimated:false completion:nil];
            [self.presentingVC.view.layer setTransform:CATransform3DIdentity];
        }];
    }];
}

@end

@implementation UIViewController (TaoBaoAnimation)

- (CATransform3D)firstTransform{
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1.0/-900;
    //带点缩小的效果
    t1 = CATransform3DScale(t1, 0.95, 0.95, 1);
    //绕x轴旋转
    t1 = CATransform3DRotate(t1, 15.0 * M_PI/180.0, 1, 0, 0);
    return t1;
    
}

- (CATransform3D)secondTransform{
    
    CATransform3D t2 = CATransform3DIdentity;
    t2.m34 = [self firstTransform].m34;
    //向上移
    t2 = CATransform3DTranslate(t2, 0, -50, 0);
    //第二次缩小
    t2 = CATransform3DScale(t2, 0.85, 0.75, 1);
    return t2;
}

@end
