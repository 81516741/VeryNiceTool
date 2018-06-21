//
//  ViewController.m
//  宫格布局
//
//  Created by ld on 16/9/8.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "LDGridView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *myVIew;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LDGridView * gridView = [[LDGridView alloc]initWithFrame:CGRectMake(0, 100, 300, 300)];
    [self.view addSubview:gridView];
    [gridView configItemsByItemCount:10 column:3 itemHeight:50 fetchItemAtIndex:^UIView *(NSInteger index) {
        UIView * textView = [[[NSBundle mainBundle]loadNibNamed:@"TextView" owner:nil options:nil]lastObject];
        return textView;
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  
}
@end
