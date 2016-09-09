//
//  ViewController.m
//  设置小红点
//
//  Created by ld on 16/9/9.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "UIView+badge.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.imageView.badgeNo) {
        self.imageView.badgeNo = @"1";
    }else{
        self.imageView.badgeNo = nil;
    }
}

@end
